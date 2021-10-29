//
//  ImageCacheTests.swift
//  The Cat AppTests
//
//  Created by ahmed sultan on 28/10/2021.
//

import XCTest
@testable import The_Cat_App

final class ImageCacheTests: XCTestCase {

    var imageCache: DefaultImageCache!
    
    override func setUpWithError() throws {
        imageCache = DefaultImageCache()
    }

    override func tearDownWithError() throws {
    }
    
    func testSetImage() {
        
        // given
        
        let key = "image1"
        let image = UIImage()
        
        // when
        
        imageCache.setImage(image, key: key)
        
        let storedImage = imageCache.getImage(forKey: key)
        
        // then
        
        XCTAssertNotNil(storedImage)
    }
}
