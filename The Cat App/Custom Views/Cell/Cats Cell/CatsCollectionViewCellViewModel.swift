//
//  CatsCollectionViewCellViewModel.swift
//  The Cat App
//
//  Created by ahmed sultan on 27/10/2021.
//

import UIKit
import Combine

final class CatsCollectionViewCellViewModel {
    
    //MARK:- Properties
    
    private var imageLoader: ImageDownloader
    private var anyCancellable: Set<AnyCancellable> = []
    var activityIndicatorAppearence = CurrentValueSubject<Bool, Never>(true)

    //MARK:- Outputs
    
    @Published private(set) var catImage: UIImage? = nil
    @Published private(set) var catName: String = ""
    private(set) var activityIndicatorShouldAppear: AnyPublisher<Bool, Never>

    //MARK:- Inputs
    
    func setData(for catModel: CatModel) {
        if catModel.breeds?.count ?? 0 > 0 {
            catName = catModel.breeds?[0].name ?? ""
        }
        downloadImage(urlString: catModel.url)
    }
    
    //MARK:- Custom actions
    
    private func downloadImage(urlString: String?) {
        activityIndicatorAppearence.send(true)
        do {
            try imageLoader.loadImage(from: urlString).sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.activityIndicatorAppearence.send(false)
            }, receiveValue: { [weak self] catImage in
                guard let self = self else { return }
                self.catImage = catImage
                self.activityIndicatorAppearence.send(false)
            }).store(in: &anyCancellable)
        } catch {
            self.activityIndicatorAppearence.send(false)
        }
    }
    
    //MARK:- Initializer

    init() {
        imageLoader = ImageLoader()
        activityIndicatorShouldAppear = AnyPublisher<Bool, Never>(activityIndicatorAppearence)
    }
}
