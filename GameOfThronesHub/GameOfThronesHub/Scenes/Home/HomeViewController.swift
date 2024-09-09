//
//  HomeViewController.swift
//  GameOfThronesHub
//
//  Created by Bengi Anıl on 8.09.2024.
//

import UIKit

class HomeViewController: UIViewController {
    private var homeViewModel: HomeViewModel!
    
    override func viewDidLoad() {
        self.homeViewModel = HomeViewModel()
        Task {
            await homeViewModel.getHouseList()
        }
    }
}
