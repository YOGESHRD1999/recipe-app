//
//  RecipeAppUITests.swift
//  RecipeAppUITests
//
//  Created by Yogesh on 1/22/25.
//


import XCTest

final class RecipesViewTests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func testSearchBarExists() {
        let searchBar = app.textFields["searchBar"]
        XCTAssertTrue(searchBar.waitForExistence(timeout: 10), "The search bar should exist.")
    }

    func testRecipeListLoads() {
        let recipeList = app.scrollViews["recipeList"]
        XCTAssertTrue(recipeList.waitForExistence(timeout: 20), "The recipe list should appear within the timeout.")
    }

    func testErrorHandling() {
        // Launch the app with a test argument to trigger error conditions
        app.launchArguments.append("--invalid-url") // Custom argument for invalid URL
        app.launch()

        // Verify if the error message appears
        let errorMessage = app.staticTexts["errorMessage"]
        XCTAssertTrue(errorMessage.waitForExistence(timeout: 10), "The error message should be displayed when fetching recipes fails.")
    }
    
}
