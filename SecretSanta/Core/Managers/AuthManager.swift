//
//  AuthManager.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 06.04.2024.
//

import Foundation
import Moya
import SwiftKeychainWrapper

final class AuthManager {
    static let shared = AuthManager()
    
    private let provider = MoyaProvider<AuthTarget>(
        plugins: [
            NetworkLoggerPlugin(configuration: NetworkLoggerPluginConfig.prettyLogging),
            LoggerPlugin()
        ]
    )
    
    var refreshingToken = false
    var onRefreshBlocks = [(String) -> Void]()
    
    private var wrapper: KeychainWrapper = .standard
    
    private var accessToken: String? {
        return wrapper.string(forKey: "accessToken")
    }
    
    var isSignedIn: Bool {
        return accessToken != nil
    }
    
    private var refreshToken: String? {
        return wrapper.string(forKey: "refreshToken")
    }
    
    private var tokenExpirasionDate: Date? {
        return UserDefaults.standard.object(forKey: "expiresIn") as? Date
    }
    
    private var shouldRefreshToken: Bool {
        guard let tokenExpirasionDate else { return false }
        let currentDate = Date()
        let fiveMinutes: TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMinutes) >= tokenExpirasionDate
    }
    
    func login(email: String, password: String, completion: @escaping(APIResult<Void>) -> ()){
        provider.request(.auth(email: email, password: password)) { [weak self] result in
            switch result {
            case .success(let response):
                guard let result = try? response.map(AuthResponse.self) else {
                    completion(.failure(.incorrectJson))
                    return
                }
                self?.cacheToken(result: result)
                completion(.success(()))
            case .failure(let error):
                completion(.failure(.failedWith(error: error.localizedDescription)))
            }
        }
    }
    
    func register(login: String, email: String, password: String, completion: @escaping(APIResult<Void>) -> ()){
        provider.request(.register(login: login, email: email, password: password)) { [weak self] result in
            switch result {
            case .success(let response):
                guard let result = try? response.map(AuthResponse.self) else {
                    completion(.failure(.incorrectJson))
                    return
                }
                self?.cacheToken(result: result)
                completion(.success(()))
            case .failure(let error):
                completion(.failure(.failedWith(error: error.localizedDescription)))
            }
        }
    }
    
    public func withValidToken(completion: @escaping (String) -> Void) {
        guard !refreshingToken else {
            onRefreshBlocks.append(completion)
            return
        }
        
        if shouldRefreshToken {
            refreshAccessToken { [weak self] success in
                if success, let accessToken = self?.accessToken {
                    completion(accessToken)
                }
            }
        } else {
            guard let accessToken else { return }
            completion(accessToken)
        }
    }
    
    public func refreshAccessToken(completion: ((Bool) -> Void)? = nil) {
        guard !refreshingToken else {
            return
        }
        
        guard shouldRefreshToken else {
            completion?(true)
            return
        }
        refreshingToken = true
        
        guard let refreshToken else { return }
        provider.request(.refresh(refreshToken: refreshToken)) { [weak self] result in
            self?.refreshingToken = false
            
            switch result {
            case .success(let response):
                do {
                    let result = try JSONDecoder().decode(AuthResponse.self, from: response.data)
                    print("Successfully refreshed")
                    self?.onRefreshBlocks.forEach { $0(result.accessToken) }
                    self?.onRefreshBlocks.removeAll()
                    self?.cacheToken(result: result)
                    completion?(true)
                } catch {
                    print(error.localizedDescription)
                    completion?(false)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion?(false)
            }
        }
    }
    
    private func cacheToken(result: AuthResponse){
        wrapper.set(result.accessToken, forKey: "accessToken")
        
        if let refreshToken = result.refreshToken {
            KeychainWrapper.standard.set(refreshToken, forKey: "refreshToken")
        }

        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(1800)), forKey: "expiresIn")
    }
    
    func removeTokens(){
        KeychainWrapper.standard.removeObject(forKey: "accessToken")
        KeychainWrapper.standard.removeObject(forKey: "refreshToken")
    }
    
}
