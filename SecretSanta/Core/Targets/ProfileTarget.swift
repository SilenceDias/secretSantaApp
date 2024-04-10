//
//  ProfileTarget.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 07.04.2024.
//

import Foundation
import Moya

enum ProfileTarget {
    case getInfo
    case updateLoginAndEmail(login: String, email: String)
    case updatePassword(current: String, newPassword: String, confirm: String)
}

extension ProfileTarget: TargetType {
    var baseURL: URL {
        return URL(string: "http://51.107.14.25:8080")!
    }
    
    var path: String {
        switch self {
        case .getInfo:
            return "/settings/user-info"
        case .updateLoginAndEmail:
            return "settings/update-login-email"
        case .updatePassword:
            return "/settings/change-password"
        }
        
    }
    
    var method: Moya.Method {
        switch self {
        case .getInfo:
            return .get
        case .updateLoginAndEmail:
            return .post
        case .updatePassword:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getInfo:
            return .requestPlain
        case .updateLoginAndEmail(let login, let email):
            return .requestParameters(
                parameters: [
                    "newLogin": login,
                    "newEmail": email
                ],
                encoding: JSONEncoding.default)
        case .updatePassword(let current, let newPassword, let confirm):
            return .requestParameters(
                parameters: [
                    "currentPassword": current,
                    "newPassword": newPassword,
                    "confirmPassword": confirm
                ],
                encoding: JSONEncoding.default)
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
