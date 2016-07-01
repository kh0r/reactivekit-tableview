//
//  reactivekit_tableviewUITests.swift
//  reactivekit-tableviewUITests
//
//  Created by Markus Klepp on 01/07/16.
//  Copyright © 2016 mklepp. All rights reserved.
//

import XCTest

class reactivekit_tableviewUITests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    XCUIApplication().launch()
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testFilterAddCrash() {
    
    
    let app = XCUIApplication()
    let tables = app.tables
    
    app.buttons["Filter"].tap()
    
    let countBefore = tables.cells.count
    app.buttons["Add"].tap()
    let countAfter = tables.cells.count
    
    XCTAssert(countBefore < countAfter)
  }
  
  func testFilterRemoveCrash() {
    let app = XCUIApplication()
    let tables = app.tables
    
    app.buttons["Filter"].tap()
    
    let countBefore = tables.cells.count
    app.buttons["Delete"].tap()
    let countAfter = tables.cells.count
    
    XCTAssert(countBefore > countAfter)
  }
  
}
