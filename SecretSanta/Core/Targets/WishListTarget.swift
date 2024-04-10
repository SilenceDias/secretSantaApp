//
//  WishListTarget.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 10.04.2024.
//

import Foundation
import Moya

enum WishListTarget {
    case createWishList(gameId: String, presents: [String])
    case myGifteeWishList(gameId: String)
}

extension WishListTarget: TargetType {
    var baseURL: URL {
        return URL(string: "http://51.107.14.25:8080")!
    }
    
    var path: String {
        switch self {
        case .createWishList(let gameId, let presents):
            return "/wishlist/\(gameId)/create-wishlist"
        case .myGifteeWishList(let gameId):
            return "/wishlist/\(gameId)/my-giftee-wishlist"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createWishList:
            return .post
        case .myGifteeWishList:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .createWishList(let gameId, let presents):
            return .requestJSONEncodable(presents)
        case .myGifteeWishList:
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
