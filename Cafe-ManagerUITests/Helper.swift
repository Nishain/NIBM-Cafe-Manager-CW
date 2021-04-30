//
//  Helper.swift
//  Cafe-ManagerUITests
//
//  Created by Nishain on 4/30/21.
//  Copyright © 2021 Nishain. All rights reserved.
//

import Foundation
import XCTest
class Helper {
    static func typeText(field:String,value:String,app:XCUIApplication){
        app.textFields[field].tap()
        clearTextIfNecessary(textField: app.textFields[field],app: app)
        app.textFields[field].typeText(value)
    }
    static func typeText(textField:XCUIElement,value:String,app:XCUIApplication){
        textField.tap()
        clearTextIfNecessary(textField: textField,app: app)
        textField.typeText(value)
    }
    static func handleAlert(title:String,app:XCUIApplication,buttonName:String="Ok",timeOut:Double=0){
        XCTAssertTrue(timeOut == 0 ? app.alerts[title].exists : app.alerts[title].waitForExistence(timeout: timeOut))
        app.alerts[title].buttons[buttonName].tap()
    }
    static func clearTextIfNecessary(textField:XCUIElement,app:XCUIApplication){
        let value = textField.value as! String
        if value.count > 0{
            var removeString = ""
            value.forEach({_ in removeString.append(XCUIKeyboardKey.delete.rawValue)})
            textField.typeText(removeString)
        }
    }
}

