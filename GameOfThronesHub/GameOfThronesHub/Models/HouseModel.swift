//
//  HouseModel.swift
//  GameOfThronesHub
//
//  Created by Bengi Anıl on 8.09.2024.
//

import Foundation

struct House: Codable, Hashable {
    let url: String
    let name: String
    let region: String
    let coatOfArms: String
    let words: String
    let titles: [String]
    let seats: [String]
    let currentLord: String
    let heir: String
    let overlord: String
    let founded: String
    let founder: String
    let diedOut: String
    let ancestralWeapons: [String]
    let cadetBranches: [String]
    let swornMembers: [String]
}
