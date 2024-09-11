//
//  DetailViewModel.swift
//  GameOfThronesHub
//
//  Created by Bengi Anıl on 10.09.2024.
//

import Foundation

class DetailViewModel {
   
    var house: House
    @Published var swornMembers: String = ""
    @Published var swornMemberList: [String] = []

    init(house: House) {
        self.house = house
    }
    
    func getHouseName() -> String {
        return house.name
    }
    
    func getRegionName() -> String {
        return house.region
    }
    
    func getWords() -> String {
        guard !house.words.isEmpty else { return "" }
        return "They say:\n \(house.words)"
    }
    
    func getArms() -> String {
        return house.coatOfArms
    }
    
    func getSwornMembers() async {
        for memberUrl in house.swornMembers {
            do {
                let char: Character = try await NetworkManager.shared.fetchData(url: memberUrl)
                swornMemberList.append(char.name)
            } catch {
                print("Failed to fetch sworn url: \(error.localizedDescription)")
            }
        }
        
        swornMembers = swornMemberList.joined(separator: ", ")
    }
}
