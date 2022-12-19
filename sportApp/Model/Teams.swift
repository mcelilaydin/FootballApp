//
//  Teams.swift
//  sportApp
//
//  Created by Celil Aydın on 16.12.2022.
//

import Foundation

struct Welcome: Codable {
    let data: [Team]
}

// MARK: - Datum
struct Team: Codable {
    let teamID: Int
    let name, shortCode: String
    let commonName: String?
    let logo: String

    enum CodingKeys: String, CodingKey {
        case teamID = "team_id"
        case name
        case shortCode = "short_code"
        case commonName = "common_name"
        case logo
    }
}
