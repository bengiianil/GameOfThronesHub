//
//  UIStoryboard+.swift
//  GameOfThronesHub
//
//  Created by Bengi Anıl on 9.09.2024.
//

import UIKit

extension UIStoryboard {
    
    static func createViewController<T: UIViewController>() -> T {
        let storyboard = UIStoryboard(name: T.identifier, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: T.identifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.identifier)")
        }
        return viewController
    }
}

extension UIViewController: Identifiable {

    static var identifier: String {
        return String(describing: self)
    }
}
