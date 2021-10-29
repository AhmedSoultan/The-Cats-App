//
//  DefaultNetworkTests.swift
//  The Cat AppTests
//
//  Created by ahmed sultan on 28/10/2021.
//

import XCTest
import Combine
@testable import The_Cat_App

final class DefaultNetworkTests: XCTestCase {

    private var network: DefaultNetwork!
    private var anyCancellable: Set<AnyCancellable>!

    override func setUpWithError() throws {
        network = DefaultNetwork()
        anyCancellable = []
    }
    
    func testGetCatsList() throws {
        
        // given
        
        let expectation = expectation(description: "cats list is downloaded")
        var error: Error?
        var catsList = [CatModel]()
        let url = "https://api.thecatapi.com/v1/images/search?limit=5"
        
        // when
        
        try network.getCatsList(url: url).sink { completion in
            switch completion {
            case .finished:
                break
            case .failure(let encounteredError):
                error = encounteredError
            }
            expectation.fulfill()
        } receiveValue: { cats in
            catsList = cats
        }.store(in: &anyCancellable)
        waitForExpectations(timeout: 10.0)
        
        // then
        
        XCTAssertNil(error)
        XCTAssertFalse(catsList.isEmpty, "cats list downloaded")
        
    }
}
