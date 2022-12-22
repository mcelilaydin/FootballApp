//
//  Player.swift
//  sportApp
//
//  Created by Celil Aydın on 22.12.2022.
//

import Foundation

struct Players: Codable {
    let data: [Player]
}

// MARK: - Datum
struct Player: Codable {
    let playerID: Int
    let firstname, lastname, birthday: String
    let age: Int
    let weight, height: Int?
    let img: String

    enum CodingKeys: String, CodingKey {
        case playerID = "player_id"
        case firstname, lastname, birthday, age, weight, height, img
    }
}
