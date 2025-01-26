//
//  RecipeAppUITestsLaunchTests.swift
//  RecipeAppUITests
//
//  Created by Yogesh on 1/22/25.
//

import XCTest

final class RecipeAppUITestsLaunchTests: XCTestCase {
    
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Insert steps to perform after app launch, if needed
        // Example: Check if the launch screen displays the app title
        XCTAssertTrue(app.staticTexts["Welcome to Recipe App"].exists, "The welcome text should appear on the launch screen.")
        
        // Take a screenshot of the launch screen
        let screenshot = app.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
