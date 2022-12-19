//
//  League.swift
//  sportApp
//
//  Created by Celil Aydın on 19.12.2022.
//

import Foundation

struct Leagues: Codable {
    let data: [String: League]
}


// MARK: - Datum
struct League: Codable {
    let leagueID, countryID: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case leagueID = "league_id"
        case countryID = "country_id"
        case name
    }
}
