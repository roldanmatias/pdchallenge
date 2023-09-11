//
//  PDChallengeUITests.swift
//  PDChallengeUITests
//
//  Created by Matias Roldan on 06/09/2023.
//

import XCTest

final class PDChallengeUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testCharactersTableViewController_showCharacters() throws {
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.tables.element(boundBy: 0).cells.count > 0)
        XCTAssertTrue(app.searchFields.count > 0)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
