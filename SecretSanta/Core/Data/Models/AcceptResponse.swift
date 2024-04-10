//
//  AcceptResponse.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 10.04.2024.
//

import Foundation

struct AcceptResponse: Decodable {
    let gameId: String
    let message: String
}
