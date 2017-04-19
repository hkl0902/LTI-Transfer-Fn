//
//  LTI_ProjectTests.swift
//  LTI-ProjectTests
//
//  Created by Hyunkyu Lee on 4/13/17.
//  Copyright © 2017 Hyunkyu Lee. All rights reserved.
//

import XCTest
@testable import LTI_Project

class LTI_ProjectTests: XCTestCase {
    
    var vc: ViewController!
    var brain: GraphBrain!
    
    override func setUp() {
        super.setUp()
        brain = vc.graph
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
