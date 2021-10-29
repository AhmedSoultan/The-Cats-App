//
//  CatsViewController.swift
//  The Cat App
//
//  Created by ahmed sultan on 25/10/2021.
//

import UIKit
import Combine

class CatsViewController: UIViewController {
    
    //MARK:- Properties
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private var activityIndicatorShouldAppear: Bool = false {
        didSet {
            switch activityIndicatorShouldAppear {
            case true:
                self.showLoadingView()
            case false:
                self.removeLoadingView()
            }
        }
    }
    
    private var viewModel = CatsControllerViewModel()
    private var anyCancellable: Set<AnyCancellable> = []
    private var coordinator = Coordinator.shared

    //MARK:- Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Cats"
        configureCollectionViewConstraint()
        configureCollectionView()
        bind()
        viewModel.viewDidLoad()
    }
    
    //MARK:- Custom actions
        
    func bind() {
        viewModel.activityIndicatorShouldAppear.assign(to: \.activityIndicatorShouldAppear, on: self).store(in: &anyCancellable)
        
        viewModel.errorMessage.receive(on: DispatchQueue.main).sink { [weak self] errorMessage in
            guard let self = self else {return}
            self.coordinator.main.navigate(to: .alert(title: "Error", message: errorMessage, buttonTitle: "Dismiss"), with: .present, on: self.navigationController)
        }.store(in: &anyCancellable)
        
        viewModel.$catsList.sink { [weak self] _ in
            guard let self = self else {return}
            self.coordinator.main.dismissAlert(on: self.navigationController)
            self.collectionView.reloadData()
        }.store(in: &anyCancellable)
    }
    
    private func configureCollectionViewConstraint() {
        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
        ])
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CatsCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CatsCollectionViewCell.self))
    }
}

//MARK:- Collection view data source

extension CatsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.catsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CatsCollectionViewCell.self), for: indexPath) as? CatsCollectionViewCell else{
            fatalError()
        }
        cell.viewModel.setData(for: self.viewModel.catsList[indexPath.item])
        return cell
    }
    
}

//MARK:- Collection view flow layout delegate

extension CatsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = indexPath.item == 0 ? collectionView.bounds.width : collectionView.bounds.width / 2
        let height = collectionView.bounds.height / 3
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
