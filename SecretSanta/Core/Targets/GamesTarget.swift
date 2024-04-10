//
//  GamesTarget.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 07.04.2024.
//

import Foundation
import Moya

enum GamesTarget {
    case getGames
    case createGame(name: String, maxPrice: Int, priceLimitChecked: Bool)
    case reshuffle(gameId: String)
}

extension GamesTarget: TargetType {
    var baseURL: URL {
        return URL(string: "http://51.107.14.25:8080")!
    }
    
    var path: String {
        switch self {
        case .createGame:
            return "/games/create-game"
        case .getGames:
            return "/games/mygames"
        case .reshuffle(let gameId):
            return "/games/\(gameId)/reshuffle"
        }
        
    }
    
    var method: Moya.Method {
        switch self {
        case .createGame:
            return .post
        case .getGames:
            return .get
        case .reshuffle:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .createGame(let name, let maxPrice, let priceLimitChecked):
            return .requestParameters(
                parameters: [
                    "name": name,
                    "maxPrice": maxPrice,
                    "priceLimitChecked": priceLimitChecked
                ],
                encoding: JSONEncoding.default)
        case .getGames:
            return .requestPlain
        case .reshuffle:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        var header = [String : String]()
        AuthManager.shared.withValidToken { token in
            header["Authorization"] = "Bearer \(token)"
        }
        return header
    }
    
    
}
