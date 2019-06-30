//
//  SNYKit_ExampleUITests.swift
//  SNYKit_ExampleUITests
//
//  Created by Sunny on 2019/6/3.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest

class SNYKit_ExampleUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        for _ in 1...1000 {
            testButton()
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testButton() {
        
        let app = XCUIApplication()
        let button = app.buttons["你好呀！"]
        button.tap()
        
        let yesAlert = app.alerts["Yes"]
        yesAlert.buttons["YES"].tap()
        button.tap()
        yesAlert.buttons["NO"].tap()
        app.otherElements.containing(.navigationBar, identifier:"SNYKit_Example.View").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.press(forDuration: 0.7);
        
    }

}
