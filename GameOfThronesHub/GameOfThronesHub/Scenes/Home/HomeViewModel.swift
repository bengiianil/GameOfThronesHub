//
//  HomeViewModel.swift
//  GameOfThronesHub
//
//  Created by Bengi Anıl on 8.09.2024.
//

import Combine
import Foundation

class HomeViewModel {
    
    @Published var houseContent: [House] = []
    @Published var houseList: [HouseCellViewModel] = []
    private var page = 1
    private let pageSize = 20
    private var isLoading = false
    private var canLoadMore = true

    init(houseContent: [House] = []) {
        self.houseContent = houseContent
    }
    
    func getHouseList() async {
        guard !isLoading && canLoadMore else { return }
        
        isLoading = true
        
        let url = "\(Urls.baseUrl)\(Paths.houses)?page=\(page)&pageSize=\(pageSize)"
        print(url)
        do {
            let houseContent: [House] = try await NetworkManager.shared.fetchData(url: url)
            
            if houseContent.isEmpty {
                canLoadMore = false
            } else {
                let newViewModels = houseContent.map { HouseCellViewModel(house: $0) }
                self.houseContent.append(contentsOf: houseContent)
                self.houseList.append(contentsOf: newViewModels)
                page += 1
            }
        } catch {
            print("Failed to fetch house list: \(error.localizedDescription)")
        }
        
        isLoading = false
    }
    
    func getCellViewModel(atIndex index: Int) -> HouseCellViewModel? {
        if houseList.count > index {
            return houseList[index]
        }
        return nil
    }
}
