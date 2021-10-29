//
//  CustomActivityIndicatorView.swift
//  The Cat App
//
//  Created by ahmed sultan on 26/10/2021.
//


import UIKit
class CustomActivityIndicatorView: UIView {
    
    //MARK:- Properties
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style  = .large
        activityIndicator.color  = .systemPink
        activityIndicator.backgroundColor = .clear
        activityIndicator.layer.cornerRadius = 10
        activityIndicator.layer.masksToBounds = true
        return activityIndicator
    }()
    
    //MARK:- Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .lightGray
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Custom action
    
    private func configure() {
        self.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.heightAnchor.constraint(equalToConstant: 70).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 70).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
