//
//  GameUserManager.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 10.04.2024.
//

import Foundation
import Moya

final class GameUserManager {
    static let shared = GameUserManager()
    
    private let provider = MoyaProvider<GameUserTarget>(
        plugins: [
            NetworkLoggerPlugin(configuration: NetworkLoggerPluginConfig.prettyLogging),
            LoggerPlugin()
        ]
    )
    
    public func sendContactInfo(gameId: String, name: String, email: String, phone: String, completion: @escaping(APIResult<Void>) -> ()){
        provider.request(.setContactInfo(gameId: gameId, name: name, email: email, phone: phone)) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    public func listBeforeShuffle(gameId: String, completion: @escaping(APIResult<[ListOfPlayers]>) -> ()){
        provider.request(.listOfPlayers(gameId: gameId)) { result in
            switch result {
            case .success(let response):
                guard let result = try? response.map([ListOfPlayers].self) else {
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
