//
//  HomeViewModel.swift
//  GameOfThronesHub
//
//  Created by Bengi Anıl on 8.09.2024.
//

import Combine
import Foundation

class HomeViewModel {
    
    @Published var houseContent: [House]?
    @Published var houseList: [HouseCellViewModel] = []

    init(houseContent: [House]? = nil) {
        self.houseContent = houseContent
    }
    
    func getHouseList() async {
        let url = Urls.baseUrl + Paths.houses

        do {
            let houseContent: [House] = try await NetworkManager.shared.fetchData(url: url)
            self.houseContent = houseContent
            self.houseList = houseContent.compactMap { HouseCellViewModel(house: $0 ) }

        } catch {
            print("Failed to fetch house list: \(error.localizedDescription)")
        }
    }
        
    func getCellViewModel(atIndex index: Int) -> HouseCellViewModel? {
        if houseList.count > index {
            return houseList[index]
        }
        return nil
    }
}
