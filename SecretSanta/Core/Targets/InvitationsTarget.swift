//
//  InvitationsTarget.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 09.04.2024.
//

import Foundation
import Moya

enum InvitationsTarget {
    case generateLink(id: String)
    case generateIosLink(id: String)
    case accept(link: String)
    case sendEmail(id: String, info: [SendInvitationModel])
}

extension InvitationsTarget: TargetType {
    var baseURL: URL {
        return URL(string: "http://51.107.14.25:8080")!
    }
    
    var path: String {
        switch self {
        case .generateLink:
            return "/invitations/generate-link"
        case .generateIosLink:
            return "/invitations/generate-link/ios"
        case .accept(let link):
            return "/invitations/accept/\(link)"
        case .sendEmail:
            return "/invitations/send"

            
        }
    }
    
    var method: Moya.Method {
        switch self{
        case .accept:
            return .post
        case .generateIosLink:
            return .get
        case .generateLink:
            return .get
        case .sendEmail:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .generateLink(let id):
            return .requestParameters(parameters: [
                "gameId": id
            ], encoding: URLEncoding.default)
        case .generateIosLink(let id):
            return .requestParameters(parameters: [
                "gameId": id
            ], encoding: URLEncoding.default)
        case .accept:
            return .requestPlain
        case .sendEmail(let id, let info):
            return .requestParameters(parameters: [
                "": info
            ], encoding: JSONEncoding.default)
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
