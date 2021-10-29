//
//  ImageLoader.swift
//  The Cat App
//
//  Created by ahmed sultan on 27/10/2021.
//

import UIKit
import Combine

final class ImageLoader: ImageDownloader {
    
    private let imageCache = DefaultImageCache()
    private var networkReahability = NetworkReachability.shared
    private var isReachable: Bool = false
    private var anyCancellable: Set<AnyCancellable> = []
    
    init() {
        networkReahability.$reachable.assign(to: \.isReachable, on: self).store(in: &anyCancellable)
    }
    
    func loadImage(from urlString: String?) throws -> AnyPublisher<UIImage?, Error> {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            throw CAError.invalidUrl
        }
        if let storedImage = imageCache.getImage(forKey: url.path) {
            return Future<UIImage?, Error>{ promise in
                promise(.success(storedImage))
            }.eraseToAnyPublisher()
        }
        guard isReachable == true else {
            throw CAError.newworkNotReachable
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap {[weak self] output in
                guard let image = UIImage(data: output.data) else { throw CAError.invalidData }
                self?.imageCache.setImage(image, key: url.path)
                return image
            }
            .subscribe(on: DispatchQueue.global(qos: .userInteractive))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

protocol ImageDownloader {
    func loadImage(from url: String?) throws -> AnyPublisher<UIImage?, Error>
}
