//
//  UIViewControllerExtension.swift
//  The Cat App
//
//  Created by ahmed sultan on 26/10/2021.
//

import UIKit

fileprivate var activityIndicatorView: CustomActivityIndicatorView!

extension UIViewController {
    
    func showLoadingView() {
        activityIndicatorView = CustomActivityIndicatorView(frame: .zero)
        self.view.addSubview(activityIndicatorView)
        configure()
        activityIndicatorView.activityIndicator.startAnimating()
    }
    
    func removeLoadingView() {
        activityIndicatorView.activityIndicator.stopAnimating()
        activityIndicatorView.isHidden = true
        activityIndicatorView.removeFromSuperview()
    }
    
    private func configure() {
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        activityIndicatorView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        activityIndicatorView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        activityIndicatorView.layer.cornerRadius = 10
    }
}

