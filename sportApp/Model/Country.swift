//
//  Country.swift
//  sportApp
//
//  Created by Celil Aydın on 17.12.2022.
//

import Foundation

struct Countrys: Codable {
    let data: [String: Country]
}

struct Country: Codable {
    let countryID: Int
    let name: String
    let countryCode: String?

    enum CodingKeys: String, CodingKey {
        case countryID = "country_id"
        case name
        case countryCode = "country_code"
    }
}
