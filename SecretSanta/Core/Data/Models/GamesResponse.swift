//
//  GamesResponse.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 07.04.2024.
//

import Foundation

struct GamesResponse: Decodable {
    let id: String
    let name: String
    let maxPrice: Int
    let creatorId: String
    let participantCount: Int
    let role: String
    let status: String
}


