//
//  Country.swift
//  Milestone 13-15
//
//  Created by Clément Villanueva on 21/08/2022.
//

import Foundation

struct Country: Codable {
    var name: String
    var motto: String
    var hymn: String
    var nationalDay: String
    var capital: String
    var currency: String
}

struct Countries: Codable {
    var countries: [Country]
}
