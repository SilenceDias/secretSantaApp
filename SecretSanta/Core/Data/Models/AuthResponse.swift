//
//  AuthResponse.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 06.04.2024.
//

import Foundation

struct AuthResponse: Decodable {
    let accessToken: String
    let refreshToken: String?
}
