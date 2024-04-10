//
//  MyGamesResponse.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 07.04.2024.
//

import Foundation

struct MyGamesResponse: Decodable {
    let allGames: [GamesResponse]
}
