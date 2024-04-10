//
//  InvitationsManager.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 09.04.2024.
//

import Foundation
import Moya

final class InvitationsManager {
    static let shared = InvitationsManager()
    
    private let provider = MoyaProvider<InvitationsTarget>(
        plugins: [
            NetworkLoggerPlugin(configuration: NetworkLoggerPluginConfig.prettyLogging),
            LoggerPlugin()
        ]
    )
    
    public func generateLink(id: String, completion: @escaping (LinkModel) -> ()){
        provider.request(.generateLink(id: id)) { result in
            switch result{
            case .success(let response):
                guard let json = try? JSONSerialization.jsonObject(with: response.data) else { return }
                print("SUCCESS: \(json)")
                guard let urlLink = try? response.map(LinkModel.self) else {
                    break
                }
                completion(urlLink)
            case .failure(let error):
                print("error: \(error.localizedDescription)")
            }
        }
    }
    
    public func generateLinkIos(id: String, completion: @escaping (LinkModel) -> ()){
        provider.request(.generateIosLink(id: id)) { result in
            switch result{
            case .success(let response):
                guard let json = try? JSONSerialization.jsonObject(with: response.data) else { return }
                print("SUCCESS: \(json)")
                guard let urlLink = try? response.map(LinkModel.self) else {
                    break
                }
                completion(urlLink)
            case .failure(let error):
                print("error: \(error.localizedDescription)")
            }
        }
    }
    
    public func acceptInvite(link: String, completion: @escaping(APIResult<AcceptResponse>) ->()){
        provider.request(.accept(link: link)) { result in
            switch result{
            case .success(let response):
                guard let result = try? response.map(AcceptResponse.self) else {
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
