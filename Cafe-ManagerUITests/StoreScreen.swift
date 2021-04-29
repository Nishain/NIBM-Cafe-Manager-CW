//
//  StoreScreen.swift
//  Cafe-ManagerUITests
//
//  Created by Nishain on 4/27/21.
//  Copyright © 2021 Nishain. All rights reserved.
//

import XCTest
import Firebase
class StoreScreen: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func waitForFoodToLoad(){
        let app = XCUIApplication()
        expectation(for: NSPredicate(format: "count > 0"), evaluatedWith: app.tables.cells, handler: nil)
        
        waitForExpectations(timeout: 5, handler: nil)
        expectation(for: NSPredicate(format: "isEnabled == 1"), evaluatedWith: app.tables.cells.element(boundBy: 0), handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
    }
    func testAvailabilityCheck() throws {
        let app = XCUIApplication()
        waitForFoodToLoad()
        var awailabilitySwitch = app.tables.cells.element(boundBy: 0).switches.element(boundBy: 0)
        let intialValue = awailabilitySwitch.value  as! String
        print("intial Vlaue - "+String(intialValue))
        awailabilitySwitch.tap()
        app.terminate()
        app.launch()
        waitForFoodToLoad()
        awailabilitySwitch = app.tables.cells.element(boundBy: 0).switches.element(boundBy: 0)
        print("intial Vlaue - "+String(awailabilitySwitch.isSelected))
        XCTAssertTrue(intialValue != awailabilitySwitch.value as! String)
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testAddCategory() throws{
        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.staticTexts["Category"]/*[[".buttons[\"Category\"].staticTexts[\"Category\"]",".staticTexts[\"Category\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Add +"].tap()
        XCTAssertTrue(app.alerts["Missing name"].exists)
        app.alerts["Missing name"].buttons["Ok"].tap()
        //"categoryTxt"
        app.textFields.firstMatch.tap()
        let newCategoryName = "new category"
        app.textFields.firstMatch.typeText(newCategoryName)
        app.buttons["Add +"].tap()
        
        let insertedRow = app.tables.cells.staticTexts[newCategoryName]
        XCTAssertTrue(insertedRow.waitForExistence(timeout: 4))
        
        app/*@START_MENU_TOKEN@*/.staticTexts["Menu + "]/*[[".buttons[\"Menu + \"].staticTexts[\"Menu + \"]",".staticTexts[\"Menu + \"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.textFields["Select Category"].tap()
        XCTAssertTrue(app.pickerWheels[newCategoryName].waitForExistence(timeout: 5))
        app.toolbars["Toolbar"].buttons["Cancel"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Category"]/*[[".buttons[\"Category\"].staticTexts[\"Category\"]",".staticTexts[\"Category\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        insertedRow.swipeRight()
        insertedRow.swipeRight()
        XCTAssertTrue(app.alerts["Are you sure"].waitForExistence(timeout: 2))
        app.alerts.buttons["Yes remove"].tap()
        XCTAssertFalse(app.tables.cells.staticTexts[newCategoryName].waitForExistence(timeout: 3))
        
        //app.tables.cells.staticTexts
    }
    func testFoodAdd() throws{
        
        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.staticTexts["Menu + "]/*[[".buttons[\"Menu + \"].staticTexts[\"Menu + \"]",".staticTexts[\"Menu + \"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.textFields["Food name"].tap()
        elementsQuery.textFields["Food name"].typeText("sample food name")

        app.textFields["Price"].tap()
        app.textFields["Price"].typeText("not a number")
        app.tap()
        XCTAssertTrue(app.alerts["Invalid cost"].exists)
        app.alerts["Invalid cost"].buttons.firstMatch.tap()
        app.textFields["Price"].tap()
        app.textFields["Price"].typeText("120")
        app.tap()
        let selectCategoryTextField = elementsQuery.textFields["Select Category"]
        selectCategoryTextField.tap()
        app.pickerWheels.element(boundBy: 0).tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        let discountTextField = elementsQuery.textFields["Discount"]
        discountTextField.tap()
        discountTextField.typeText("not a number")
        app.tap()
        XCTAssertTrue(app.alerts["Invalid Discount"].exists)
        app.alerts["Invalid Discount"].buttons.firstMatch.tap()
        discountTextField.tap()
        discountTextField.typeText("20")
        app.tap()
        let addBtn = app.buttons["Add +"]
        addBtn.tap()
        XCTAssertTrue(app.alerts["Fields Empty"].exists)
        app.alerts["Fields Empty"].buttons.firstMatch.tap()
        app.textFields["Food description"].tap()
        app.textFields["Food description"].typeText("sample food description")
        app.tap()
        addBtn.tap()
        XCTAssertTrue(app.alerts["No image"].exists)
        app.alerts.buttons["Ok"].tap()
        elementsQuery.images["emptyFood"].tap()
        app.sheets["Choose Method"].scrollViews.otherElements.buttons["From gallery"].tap()
        app.tables.cells.element(boundBy: 1).tap()
        app.collectionViews.cells.element(boundBy: 0).tap()
        XCTAssertTrue(addBtn.waitForExistence(timeout: 4))
        addBtn.tap()
        XCTAssertTrue(app.tables.cells.staticTexts["sample food name"].waitForExistence(timeout: 6))
    }
    func testOrders(){
        let app = XCUIApplication()
        app.tabBars.tabs["Orders"].tap()
        XCTAssertTrue(app.tables.cells.staticTexts["Kamal"].waitForExistence(timeout: 3))
        
        let testingRow = app.tables.cells.allElementsBoundByIndex.first(where: {$0.staticTexts["Kamal"].exists && $0.buttons["Accept"].exists})
        XCTAssertNil(testingRow)
        testingRow!.buttons["Accept"].tap()
        XCTAssertTrue(testingRow!.buttons["Preparing"].waitForExistence(timeout: 2))
        testingRow!.buttons["Preparing"].tap()
        XCTAssertTrue(testingRow!.buttons["Ready"].waitForExistence(timeout: 2))
    }
    
}

