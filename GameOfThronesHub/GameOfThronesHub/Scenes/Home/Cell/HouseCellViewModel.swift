//
//  HouseCellViewModel.swift
//  GameOfThronesHub
//
//  Created by Bengi Anıl on 10.09.2024.
//

class HouseCellViewModel {
    private var house: House

    init(house: House) {
        self.house = house
    }

    func getHouseName() -> String {
        return house.name
    }

    func getHouseRegion() -> String {
        return house.region
    }
}
