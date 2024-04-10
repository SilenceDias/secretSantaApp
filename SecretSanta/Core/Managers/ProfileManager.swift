//
//  ProfileManager.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 10.04.2024.
//

import Foundation
import Moya

final class ProfileManager {
    static let shared = ProfileManager()
    
    private let provider = MoyaProvider<ProfileTarget>(
        plugins: [
            NetworkLoggerPlugin(configuration: NetworkLoggerPluginConfig.prettyLogging),
            LoggerPlugin()
        ]
    )
    
    public func getInfo(completion: @escaping(APIResult<UserInfo>) -> ()){
        provider.request(.getInfo) { result in
            switch result {
            case .success(let response):
                guard let result = try? response.map(UserInfo.self) else {
                    completion(.failure(.incorrectJson))
                    return
                }
                completion(.success(result))
            case .failure(let error):
                completion(.failure(.failedWith(error: error.localizedDescription)))
            }
        }
    }
    
    public func updateEmail(newLogin: String, newEmail: String, completion: @escaping(APIResult<String>) -> ()){
        provider.request(.updateLoginAndEmail(login: newLogin, email: newEmail)) { result in
            switch result {
            case .success(let response):
                guard let result = try? response.mapString() else {
                    completion(.failure(.incorrectJson))
                    return
                }
                completion(.success(result))
            case .failure(let error):
                completion(.failure(.failedWith(error: error.localizedDescription)))
            }
        }
    }
    
    public func updatePassword(oldPassword: String, newPassword: String, confirm: String, completion: @escaping(APIResult<String>) -> ()) {
        provider.request(.updatePassword(current: oldPassword, newPassword: newPassword, confirm: confirm)) { result in
            switch result {
            case .success(let response):
                guard let result = try? response.mapString() else {
                    completion(.failure(.incorrectJson))
                    return
                }
                completion(.success(result))
            case .failure(let error):
                completion(.failure(.failedWith(error: error.localizedDescription)))
            }
        }
    }
}
