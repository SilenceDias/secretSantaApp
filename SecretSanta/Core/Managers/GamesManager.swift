//
//  GamesManager.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 07.04.2024.
//

import Foundation
import Moya
import SwiftKeychainWrapper

final class GamesManager {
    
    static let shared = GamesManager()
    
    private let provider = MoyaProvider<GamesTarget>(
        plugins: [
            NetworkLoggerPlugin(configuration: NetworkLoggerPluginConfig.prettyLogging),
            LoggerPlugin()
        ]
    )
    
    func createGame(name: String, maxPrice: Int, priceLimit: Bool, unique: String, completion: @escaping(APIResult<Void>) -> ()){
        provider.request(.createGame(name: name, maxPrice: maxPrice, priceLimitChecked: priceLimit)) { result in
            switch result{
            case .success(let response):
                guard let result = try? response.map(GamesResponse.self) else {
                    completion(.failure(.incorrectJson))
                    return
                }
                completion(.success(()))
            case .failure(let error):
                completion(.failure(.failedWith(error: error.localizedDescription)))
            }
        }
    }
    
    func getGames(completion: @escaping([GamesResponse]) -> ()){
        provider.request(.getGames) { result in
            switch result{
            case .success(let response):
                guard let json = try? JSONSerialization.jsonObject(with: response.data) else { return }
                print("SUCCESS: \(json)")
                guard let gamesData = try? response.map([GamesResponse].self) else {
                    break
                }
                completion(gamesData)
            case .failure:
                completion([])
            }
        }
    }
    
    func shuffleGame(gameId: String, completion: @escaping(APIResult<Void>) -> ()){
        provider.request(.reshuffle(gameId: gameId)) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(.failedWith(error: error.localizedDescription)))
            }
        }
    }
}
