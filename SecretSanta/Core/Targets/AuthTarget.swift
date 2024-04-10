//
//  AuthTarget.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 06.04.2024.
//

import Foundation
import Moya

enum AuthTarget {
    case register(login: String, email: String, password: String)
    case auth(email: String, password: String)
    case refresh(refreshToken: String)
}

extension AuthTarget: TargetType {
    var baseURL: URL {
        return URL(string: "http://51.107.14.25:8080")!
    }
    
    var path: String {
        switch self {
        case .register:
            return "auth/register"
        case .auth:
            return "/auth/login"
        case .refresh:
            return "/auth/refresh-token"
        }
        
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Moya.Task {
        switch self {
        case .register(let login, let email, let password):
            return .requestParameters(
                parameters: [
                    "login": login,
                    "email": email,
                    "password": password
                ],
                encoding: JSONEncoding.default)
        case .auth(let email, let password):
            return .requestParameters(
                parameters: [
                    "email": email,
                    "password": password
                ],
                encoding: JSONEncoding.default)
        case .refresh(let token):
            return .requestParameters(
                parameters: [
                    "refreshToken": token
                ],
                encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
