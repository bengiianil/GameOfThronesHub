//
//  HomeViewModel.swift
//  GameOfThronesHub
//
//  Created by Bengi Anıl on 8.09.2024.
//

import Combine
import Foundation

class HomeViewModel {
    
    @Published var houseList: [House]?
    
    init(houseList: [House]? = nil) {
        self.houseList = houseList
    }
    
    func getHouseList() async {
        let url = Urls.baseUrl + Paths.houses

        do {
            let houseList: [House] = try await NetworkManager.shared.fetchData(url: url)
        } catch {
            print("Failed to fetch house list: \(error.localizedDescription)")
        }
    }
}
