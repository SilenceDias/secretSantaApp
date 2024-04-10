//
//  MyGiftee.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 10.04.2024.
//

import Foundation

struct MyGiftee: Decodable {
    let message: String?
    let gifteeEmail: String
    let wishlistDescriptions: [String]
}
