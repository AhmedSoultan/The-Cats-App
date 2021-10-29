//
//  ImageLoaderTests.swift
//  The Cat AppTests
//
//  Created by ahmed sultan on 28/10/2021.
//

import XCTest
import Combine
@testable import The_Cat_App

final class ImageLoaderTests: XCTestCase {
    
    private var imageLoader: ImageLoader!
    private var anyCancellable: Set<AnyCancellable>!

    override func setUpWithError() throws {
        imageLoader = ImageLoader()
         anyCancellable = []
    }

    func testLoadImage() throws {
        
        // given
        let url = "https://cdn2.thecatapi.com/images/km.jpg"
        var error: Error?
        var catImage: UIImage?
        let expectation = expectation(description: "\(url) image is downloaded")

        // when
        
        try imageLoader.loadImage(from: url)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let encounteredError):
                    error = encounteredError
                }
                expectation.fulfill()
            } receiveValue: { image in
                catImage = image
            }.store(in: &anyCancellable)
        
        waitForExpectations(timeout: 20.0)

        // then
        
        XCTAssertTrue(catImage != nil, "image downloaded")
        XCTAssertNil(error)
    }
}
