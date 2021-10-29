//
//  Navigator.swift
//  The Cat App
//
//  Created by ahmed sultan on 25/10/2021.
//

import UIKit

enum NavigationType {
    case push
    case present
}

protocol Navigator {
    
    associatedtype Destination
    
    func viewController(for destination: Destination) -> UIViewController
    func navigate(to destination: Destination, with navigationType: NavigationType, on navigationController: UINavigationController?)
    func dismissAlert(on navigationController: UINavigationController?)
}

extension Navigator {

    func navigate(to destination: Destination, with navigationType: NavigationType, on navigationController: UINavigationController?) {
        let viewController = self.viewController(for: destination)
        switch navigationType {
        case .push:
            navigationController?.pushViewController(viewController, animated: true)
        case .present:
            navigationController?.present(viewController, animated: true)
        }
    }
    
    func dismissAlert(on navigationController: UINavigationController?){
        navigationController?.dismiss(animated: true, completion: nil)
    }

}
