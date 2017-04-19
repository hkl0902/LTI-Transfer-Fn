//
//  LTI_ProjectUITests.swift
//  LTI-ProjectUITests
//
//  Created by Hyunkyu Lee on 4/13/17.
//  Copyright © 2017 Hyunkyu Lee. All rights reserved.
//

import XCTest
class LTI_ProjectUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        XCTAssert(true)
    }
    
}
