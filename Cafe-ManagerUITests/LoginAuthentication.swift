//
//  LoginAuthentication.swift
//  Cafe-ManagerUITests
//
//  Created by Nishain on 4/27/21.
//  Copyright © 2021 Nishain. All rights reserved.
//

import XCTest
class LoginAuthentication: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    var monitor:NSObjectProtocol!
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        //removeUIInterruptionMonitor(monitor)kkg
//        if(XCUIApplication().navigationBars["Cafe_Manager.MainScreenContainer"].buttons["Sign Out"].exists){
//            XCUIApplication().navigationBars["Cafe_Manager.MainScreenContainer"].buttons["Sign Out"].tap()
        
    
    }
    func openSettings(_ permissionMode:Int,skipOpening:Bool = false){
        let permissionModes = ["Never","Ask Next Time","While Using the app"]
        let settings  = XCUIApplication(bundleIdentifier: "com.apple.Preferences")
        if !skipOpening{
            settings.launch()
        }else{
            XCTAssertTrue(settings.waitForExistence(timeout: 5))
        }
        settings.tables.staticTexts["Privacy"].tap()
        settings.tables.staticTexts["Location Services"].tap()
        settings.tables.staticTexts["Cafe-Manager"].tap()
        settings.tables.staticTexts["Ask Next Time"].tap()
        settings.terminate()
    }
   
    
    
    func toggleLocationService(turnOn:Bool){
        let settings  = XCUIApplication(bundleIdentifier: "com.apple.Preferences")
         settings.launch()
         settings.tables.staticTexts["Privacy"].tap()
         settings.tables.staticTexts["Location Services"].tap()
        if settings.tables.switches["Location Services"].isSelected == turnOn{
            return settings.terminate()
        }
        if settings.tables.switches["Location Services"].isSelected{
             settings.tables.switches["Location Services"].tap()
             settings.buttons["Turn Off"].tap()
        }else{
            settings.tables.switches["Location Services"].tap()
        }
        settings.terminate()
    }
    
    func testLocationServiceAvailability() throws{
        let app = XCUIApplication()
        toggleLocationService(turnOn: false)
        app.activate()
        let locationServicePrompt = app.alerts["Location service is disabled"]
        XCTAssertTrue(locationServicePrompt.exists)
        locationServicePrompt.buttons["Open Settings"].tap()
        openSettings(0, skipOpening: true)
    }
    func testLocationAcccessPaths() throws{
        let app = XCUIApplication()
        openSettings(1)
        app.launch()
        let locationBtn = app/*@START_MENU_TOKEN@*/.staticTexts["Allow Location"]/*[[".buttons[\"Allow Location\"].staticTexts[\"Allow Location\"]",".staticTexts[\"Allow Location\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        locationBtn.tap()
        let permissionAlert = XCUIApplication(bundleIdentifier: "com.apple.springboard").alerts
        XCTAssertTrue(permissionAlert.buttons["Don’t Allow"].waitForExistence(timeout: 3))
        permissionAlert.buttons["Don’t Allow"].tap()
        
        let noNeedBtn = app.buttons["No need"]
        XCTAssertTrue(noNeedBtn.waitForExistence(timeout: 3))
        noNeedBtn.tap()
        
        locationBtn.tap()
        let locationPermissionPrompt = app.alerts["Location service is disabled"]
        let openSetting = locationPermissionPrompt.buttons["Open Settings"]
        XCTAssertTrue(openSetting.waitForExistence(timeout: 3))
        openSetting.tap()
        openSettings(1, skipOpening: true)
        app.activate()
        //locationBtn.tap()
        let button = permissionAlert.buttons["Allow While Using App"]
        XCTAssertTrue(button.waitForExistence(timeout: 3))
        button.tap()
    }
//    func testLocationAccess() throws{
//        let app = XCUIApplication()
//        openSettings(1)
//        app.launch()
//        app/*@START_MENU_TOKEN@*/.staticTexts["Allow Location"]/*[[".buttons[\"Allow Location\"].staticTexts[\"Allow Location\"]",".staticTexts[\"Allow Location\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//
////        XCTAssertTrue(permissionPromptAlert.waitForExistence(timeout: 10))
//        var popupIndex = 0;
//        monitor = addUIInterruptionMonitor(withDescription: "Alert handling", handler: {alert in
//            switch popupIndex{
//            case 0 :
//                alert.buttons["Don’t Allow"].tap()
//                popupIndex = 1;
//            case 1:
//                let missingPermissionAlert = app.alerts["Missing Permissions"]
//                XCTAssertTrue(missingPermissionAlert.exists)
//                missingPermissionAlert.buttons["No need"].tap()
//                popupIndex += 1;
//                app/*@START_MENU_TOKEN@*/.staticTexts["Allow Location"]/*[[".buttons[\"Allow Location\"].staticTexts[\"Allow Location\"]",".staticTexts[\"Allow Location\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//            case 2:
//                let missingPermissionAlert = app.alerts["Missing Permissions"]
//                XCTAssertTrue(missingPermissionAlert.exists)
//                missingPermissionAlert.buttons["Open Settings"].tap()
//                self.openSettings(2, skipOpening: true)
//                app.launch()
//                popupIndex += 1
//            default:
//                self.removeUIInterruptionMonitor(self.monitor)
//            }
//            return true
//        })
//        app.tap()
//    }
    
    func testLogin() throws{
                
        let app = XCUIApplication()
        let emailField = app.textFields["Email"]
        let passwordField = app.secureTextFields["Password"]
        emailField.tap()
        emailField.typeText("nishain.atomic@gmail.com")
        passwordField.tap()
        passwordField.typeText("123456")
        app.buttons["Login"].tap()
        let storeTab = app.tabBars.buttons["Store"]
        XCTAssertTrue(storeTab.waitForExistence(timeout: 5))
        app.navigationBars["Cafe_Manager.MainScreenContainer"].buttons["Sign Out"].tap()
        app.terminate()
        app.launch()
        XCTAssertFalse(storeTab.waitForExistence(timeout: 5))
    }
    

}
