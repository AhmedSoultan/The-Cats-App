//
//  CatsViewControllerUITests.swift
//  The Cat AppUITests
//
//  Created by ahmed sultan on 25/10/2021.
//

import XCTest

class CatsViewControllerUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        app.launch()
        app.launchArguments.append("--uiTesting")
        continueAfterFailure = false
    }
    
    func testRemoveActivityIndicator() throws {
        // given
        let app = XCUIApplication()
        let activityIndicator = app.activityIndicators["In progress"]
        
        // then
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: activityIndicator, handler: nil)
        waitForExpectations(timeout: 20.0, handler: nil)
        
    }
    
    func testcollectionViewCellAppearance() throws {
        // given
        let app = XCUIApplication()
        let collectionViewCell = app.collectionViews.children(matching: .cell).element(boundBy: 1).children(matching: .other).element
        
        // then
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: collectionViewCell, handler: nil)
        waitForExpectations(timeout: 20.0, handler: nil)
        
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
