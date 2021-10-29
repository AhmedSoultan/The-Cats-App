//
//  ImageCache.swift
//  The Cat App
//
//  Created by ahmed sultan on 27/10/2021.
//

import UIKit

final class DefaultImageCache: ImageCache {
    
    private var storage = [String: UIImage]()
    private var dispatchQueue = DispatchQueue(label: "com.privateQueue", attributes: .concurrent)
    
    func setImage(_ image: UIImage?, key: String) {
        dispatchQueue.async(flags: DispatchWorkItemFlags.barrier) {
            self.storage[key] = image
        }
    }
    
    func getImage(forKey key: String) -> UIImage? {
        var image: UIImage?
        dispatchQueue.sync {
            if let storedImage = storage[key] {
                image = storedImage
            } else {
                image = nil
            }
        }
        return image
    }
}

protocol ImageCache {
    func setImage(_ image: UIImage?, key: String)
    func getImage(forKey key: String) -> UIImage?
}
