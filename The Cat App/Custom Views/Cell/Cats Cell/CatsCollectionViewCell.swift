//
//  CatsCollectionViewCell.swift
//  The Cat App
//
//  Created by ahmed sultan on 25/10/2021.
//

import UIKit
import Combine
import Foundation

class CatsCollectionViewCell: UICollectionViewCell {
    
    //MARK:- Properties
    
    lazy var catImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    lazy var catNameLabel: CATitleLabel = {
        let label = CATitleLabel(textAlignment: .center, fontSize: 16,fontWeight: .medium)
        label.text = ""
        label.numberOfLines = 2
        label.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.clipsToBounds = true
        return label
    }()
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style  = .medium
        activityIndicator.color  = .systemPink
        activityIndicator.backgroundColor = .clear
        activityIndicator.layer.cornerRadius = 10
        activityIndicator.layer.masksToBounds = true
        return activityIndicator
    }()
    
    private var activityIndicatorShouldAppear:Bool = false {
        didSet {
            switch activityIndicatorShouldAppear {
            case true:
                self.showLoadingView()
            case false:
                self.removeLoadingView()
            }
        }
    }
    
    var viewModel = CatsCollectionViewCellViewModel()
    var anyCancellable: Set<AnyCancellable> = []

    //MARK:- Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCatImageViewConstraints()
        contentView.backgroundColor = .clear
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        resetData()
    }

    //MARK:- Custom actions
    
    private func bind() {
        viewModel.activityIndicatorShouldAppear.assign(to: \.activityIndicatorShouldAppear, on: self).store(in: &anyCancellable)

        
        viewModel.$catImage.receive(on: DispatchQueue.main).sink { [weak self] catImage in
            guard let self = self else {return}
            self.catImageView.image = catImage
        }.store(in: &anyCancellable)
        
        viewModel.$catName.receive(on: DispatchQueue.main).filter{$0 != ""}.sink { [weak self] catName in
            guard let self = self else {return}
            self.configureTitleLabelConstraints()
            self.catNameLabel.text = catName
        }.store(in: &anyCancellable)
    }

    private func resetData() {
        catNameLabel.removeFromSuperview()
        catImageView.image = UIImage()
    }

    private func configureCatImageViewConstraints() {
        self.contentView.addSubview(catImageView)
        catImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            catImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            catImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            catImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.95),
            catImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.95)
        ])
        catImageView.layer.cornerRadius = 10
    }
    
    private func configureTitleLabelConstraints() {
        self.contentView.addSubview(catNameLabel)
        catNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            catNameLabel.bottomAnchor.constraint(equalTo: catImageView.bottomAnchor),
            catNameLabel.rightAnchor.constraint(equalTo: catImageView.rightAnchor),
            catNameLabel.heightAnchor.constraint(equalToConstant: 40),
            catNameLabel.widthAnchor.constraint(equalTo: catImageView.widthAnchor, multiplier: 0.55)
        ])
        catNameLabel.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner]
        catNameLabel.layer.cornerRadius = 5
    }
    
    func showLoadingView() {
        self.contentView.addSubview(activityIndicatorView)
        configureActivityIndicator()
        activityIndicatorView.startAnimating()
    }
    
    func removeLoadingView() {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
        activityIndicatorView.removeFromSuperview()
    }
    
    private func configureActivityIndicator() {
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        activityIndicatorView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        activityIndicatorView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
