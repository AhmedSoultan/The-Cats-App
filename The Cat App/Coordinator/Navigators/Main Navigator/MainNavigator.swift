//
//  MainNavigator.swift
//  The Cat App
//
//  Created by ahmed sultan on 25/10/2021.
//

import UIKit

final class MainNavigator: Navigator {
   
    enum Destination {
        case cats
        case alert(title: String, message: String, buttonTitle: String)
    }
    
    func viewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .cats:
            return CatsViewController()
        case let .alert(title, message, buttonTitle):
            let alerController = CAAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
            alerController.modalPresentationStyle = .overCurrentContext
            alerController.modalTransitionStyle = .crossDissolve
            return alerController
        }
    }
}

