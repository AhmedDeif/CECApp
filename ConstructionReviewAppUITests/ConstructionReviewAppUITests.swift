//
//  ConstructionReviewAppUITests.swift
//  ConstructionReviewAppUITests
//
//  Created by Ahmed Abodeif on 12/25/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import XCTest

extension XCUIElement {
    func forceTapElement() {
        if self.isHittable {
            self.tap()
        }
        else {
            let coordinate: XCUICoordinate = self.coordinate(withNormalizedOffset: CGVector(dx:0.0, dy:0.0))
            coordinate.tap()
        }
    }
}

class ConstructionReviewAppUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
//        continueAfterFailure = false
//        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
//        XCUIApplication().launch()
//        let app = XCUIApplication()
//        setupSnapshot(app)
//        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        snapshot("01LoginScreen")
        let elementsQuery = app.scrollViews.otherElements
        let emailTextField = elementsQuery.textFields["Email"]
        emailTextField.tap()
        
        let returnButton = app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        returnButton.tap()
        elementsQuery.buttons["Forgot my password"].tap()
        snapshot("02ForgotPasswordScreen")
        let window = app.children(matching: .window).element(boundBy: 0)
        window.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.forceTapElement()
        snapshot("03ForgotPasswordScreenDismiss")
//        elementsQuery.buttons["Login for first time"].tap()
//        snapshot("03RegistrationScreen")
//        elementsQuery.buttons["Already have an account"].tap()
//        emailTextField.tap()
//
//        let aKey = app/*@START_MENU_TOKEN@*/.keys["a"]/*[[".keyboards.keys[\"a\"]",".keys[\"a\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        aKey.tap()
//        aKey.tap()
//
//        let hKey = app/*@START_MENU_TOKEN@*/.keys["h"]/*[[".keyboards.keys[\"h\"]",".keys[\"h\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        hKey.tap()
//        hKey.tap()
//
//        let mKey = app/*@START_MENU_TOKEN@*/.keys["m"]/*[[".keyboards.keys[\"m\"]",".keys[\"m\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        mKey.tap()
//        mKey.tap()
//
//        let eKey = app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        eKey.tap()
//        eKey.tap()
//        eKey.tap()
//
//        let cKey = app/*@START_MENU_TOKEN@*/.keys["c"]/*[[".keyboards.keys[\"c\"]",".keys[\"c\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        cKey.tap()
//        cKey.tap()
//        eKey.tap()
//        eKey.tap()
//        cKey.tap()
//        cKey.tap()
//
//        let shiftButton = app/*@START_MENU_TOKEN@*/.buttons["shift"]/*[[".keyboards.buttons[\"shift\"]",".buttons[\"shift\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        shiftButton.tap()
//
//        let moreKey = app/*@START_MENU_TOKEN@*/.keys["more"]/*[[".keyboards",".keys[\"more, numbers\"]",".keys[\"more\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
//        moreKey.tap()
//        moreKey.tap()
//
//        let key = app/*@START_MENU_TOKEN@*/.keys["4"]/*[[".keyboards.keys[\"4\"]",".keys[\"4\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        key.tap()
//        key.tap()
//
//        let key2 = app/*@START_MENU_TOKEN@*/.keys["@"]/*[[".keyboards.keys[\"@\"]",".keys[\"@\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        key2.tap()
//        key2.tap()
//
//        let moreKey2 = app/*@START_MENU_TOKEN@*/.keys["more"]/*[[".keyboards",".keys[\"more, letters\"]",".keys[\"more\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
//        moreKey2.tap()
//        moreKey2.tap()
//        mKey.tap()
//        mKey.tap()
//        aKey.tap()
//        aKey.tap()
//
//        let iKey = app/*@START_MENU_TOKEN@*/.keys["i"]/*[[".keyboards.keys[\"i\"]",".keys[\"i\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        iKey.tap()
//        iKey.tap()
//
//        let lKey = app/*@START_MENU_TOKEN@*/.keys["l"]/*[[".keyboards.keys[\"l\"]",".keys[\"l\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        lKey.tap()
//        lKey.tap()
//        iKey.tap()
//        iKey.tap()
//
//        let nKey = app/*@START_MENU_TOKEN@*/.keys["n"]/*[[".keyboards.keys[\"n\"]",".keys[\"n\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        nKey.tap()
//        nKey.tap()
//        aKey.tap()
//        aKey.tap()
//
//        let tKey = app/*@START_MENU_TOKEN@*/.keys["t"]/*[[".keyboards.keys[\"t\"]",".keys[\"t\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        tKey.tap()
//        tKey.tap()
//
//        let oKey = app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        oKey.tap()
//        oKey.tap()
//
//        let rKey = app/*@START_MENU_TOKEN@*/.keys["r"]/*[[".keyboards.keys[\"r\"]",".keys[\"r\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        rKey.tap()
//        rKey.tap()
//        moreKey.tap()
//        moreKey.tap()
//
//        let key3 = app/*@START_MENU_TOKEN@*/.keys["."]/*[[".keyboards.keys[\".\"]",".keys[\".\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        key3.tap()
//        key3.tap()
//        moreKey2.tap()
//        moreKey2.tap()
//        cKey.tap()
//        cKey.tap()
//        oKey.tap()
//        oKey.tap()
//        mKey.tap()
//        mKey.tap()
//        elementsQuery.secureTextFields["Password"].tap()
//        shiftButton.tap()
//
//        let aKey2 = app/*@START_MENU_TOKEN@*/.keys["A"]/*[[".keyboards.keys[\"A\"]",".keys[\"A\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        aKey2.tap()
//        aKey2.tap()
//        hKey.tap()
//        hKey.tap()
//        mKey.tap()
//        mKey.tap()
//        eKey.tap()
//        app/*@START_MENU_TOKEN@*/.keys["d"]/*[[".keyboards.keys[\"d\"]",".keys[\"d\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        moreKey.tap()
//        moreKey.tap()
//        app/*@START_MENU_TOKEN@*/.keys["1"]/*[[".keyboards.keys[\"1\"]",".keys[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app/*@START_MENU_TOKEN@*/.keys["2"]/*[[".keyboards.keys[\"2\"]",".keys[\"2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//
//        let key4 = app/*@START_MENU_TOKEN@*/.keys["3"]/*[[".keyboards.keys[\"3\"]",".keys[\"3\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        key4.tap()
//        key4.tap()
//        returnButton.tap()
//        elementsQuery.buttons["Login"].tap()
//        snapshot("04ProjectsScreen")
//        let tablesQuery = app.tables
//        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"16-06-18")/*[[".cells.containing(.staticText, identifier:\"CIB new capital branch\")",".cells.containing(.staticText, identifier:\"construction\")",".cells.containing(.staticText, identifier:\"10-04-19\")",".cells.containing(.staticText, identifier:\"16-06-18\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["sha3ban"].tap()
//        tablesQuery.cells.containing(.staticText, identifier:"Creating a new test issue from the iOs app").staticTexts["change response delay"].tap()
//        app.navigationBars["change response delay"].buttons["Issues"].tap()
//        tablesQuery/*@START_MENU_TOKEN@*/.buttons["More Info"]/*[[".otherElements[\"CIB new capital branch\"].buttons[\"More Info\"]",".buttons[\"More Info\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        snapshot("05ProjectDescriptionScreen")
//        window.children(matching: .other).element(boundBy: 2).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.tap()
//        snapshot("06ProjectDescriptionScreen")
//        let issuesNavigationBar = app.navigationBars["Issues"]
//        issuesNavigationBar.buttons["Add"].tap()
//        elementsQuery.textFields["Select issue type"].tap()
//        app.pickers.children(matching: .pickerWheel).element.tap()
//        app.toolbars["Toolbar"].buttons["Done"].tap()
//        app.navigationBars["Report Issue"].buttons["Issues"].tap()
//        issuesNavigationBar.buttons["Projects"].tap()
//        app.navigationBars["Projects"].buttons["Logout"].tap()

//        let elementsQuery = app.scrollViews.otherElements
//        snapshot("01LoginScreen")
//        elementsQuery.buttons["Forgot my password"].tap()
//        snapshot("02ForgetScreen")
//        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.tap()
    }
    

}
