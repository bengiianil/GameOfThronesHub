//
//  SplashViewController.swift
//  GameOfThronesHub
//
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.navigateToHomeViewController()
        }
    }
    
    @objc func navigateToHomeViewController() {
        let homeViewController: HomeViewController = UIStoryboard.createViewController()
        self.navigationController?.pushViewController(homeViewController, animated: true)
    }
}

