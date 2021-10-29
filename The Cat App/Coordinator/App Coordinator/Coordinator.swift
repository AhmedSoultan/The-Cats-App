//
//  Coordinator.swift
//  The Cat App
//
//  Created by ahmed sultan on 25/10/2021.
//

import UIKit

final class Coordinator {
    
    static var shared = Coordinator()
    
    lazy var main: MainNavigator = {
        return MainNavigator()
    }()
    
    lazy var rootView: UIViewController = {
        let rootVC = main.viewController(for: .cats)
        let naviagationController = UINavigationController(rootViewController: rootVC)
        return naviagationController
    }()
    
    private init() {}
    
    func start(with window: UIWindow?) {
        setUpNavigationAppearence()
        window?.rootViewController = rootView
        window?.makeKeyAndVisible()
    }
    
    private func setUpNavigationAppearence() {
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().barTintColor = .clear
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().backgroundColor = UIColor.clear
    }
}
