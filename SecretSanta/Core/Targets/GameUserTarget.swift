//
//  GameUserTarget.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 10.04.2024.
//

import Foundation
import Moya

enum GameUserTarget {
    case setContactInfo(gameId: String, name: String, email: String, phone: String)
    case listOfPlayers(gameId:String)
}

extension GameUserTarget: TargetType {
    var baseURL: URL {
        return URL(string: "http://51.107.14.25:8080")!
    }
    
    var path: String {
        switch self {
        case .setContactInfo(let gameId, let name, let email, let phone):
            return "/gameuser/\(gameId)/contact-info"
        case .listOfPlayers(let gameId):
            return "/gameuser/\(gameId)/list-before-shuffle"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Moya.Task {
        switch self {
        case .setContactInfo(let gameId, let name, let email, let phone):
            return .requestParameters(parameters: [
                "userName": name,
                "email": email,
                "phoneNumber": phone
            ], encoding: JSONEncoding.default)
        case .listOfPlayers:
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
