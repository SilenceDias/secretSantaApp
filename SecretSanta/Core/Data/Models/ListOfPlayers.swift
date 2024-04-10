//
//  ListOfPlayers.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 10.04.2024.
//

import Foundation

struct ListOfPlayers: Decodable {
    let id : String
    let game: String
    let user: String
    let status: String?
    let feedback: String?
    let invitationStatus: String
    let userName: String?
    let email: String?
    let phoneNumber: String?
}
