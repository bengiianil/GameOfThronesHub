//
//  HomeViewModel.swift
//  GameOfThronesHub
//
//  Created by Bengi Anıl on 8.09.2024.
//

import Foundation
import Combine

class HomeViewModel {
    
    private var model: HouseModel
    
    init(model: HouseModel) {
        self.model = model
    }
    
    func getHouseList() async {
        let url = Urls.baseUrl + Paths.houses

        do {
            let houseList: [HouseModel] = try await NetworkManager.fetchData(url: url)
            print(houseList) // Handle the fetched list of houses
        } catch {
            print("Failed to fetch house list: \(error)")
        }

    }
}
