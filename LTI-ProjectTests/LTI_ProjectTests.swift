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
    
    //var brain: SolverBrain
    
    var window: UIWindow?
    var vc: ViewController?
    
    override func setUp() {
        super.setUp()
        vc = ViewController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
            
        //let homeController = HomeController(collectionViewLayout: UICollectionViewFlowLayout())
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
        //brain = SolverBrain()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPolynomialMultiplication() {
        XCTAssert(true)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
