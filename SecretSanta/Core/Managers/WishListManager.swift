//
//  WishListManager.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 10.04.2024.
//

import Foundation
import Moya

final class WishListManager {
    static let shared = WishListManager()
    
    private let provider = MoyaProvider<WishListTarget>(
        plugins: [
            NetworkLoggerPlugin(configuration: NetworkLoggerPluginConfig.prettyLogging),
            LoggerPlugin()
        ]
    )
    
    public func sendWishList(gameId: String, presents: [String], completion: @escaping(APIResult<Void>) -> ()){
        provider.request(.createWishList(gameId: gameId, presents: presents)) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    public func myGifteeData(gameId: String, completion: @escaping (APIResult<MyGiftee>) -> ()){
        provider.request(.myGifteeWishList(gameId: gameId)) { result in
            switch result {
            case .success(let response):
                guard let result = try? response.map(MyGiftee.self) else {
                    completion(.failure(.incorrectJson))
                    return
                }
                completion(.success(result))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
