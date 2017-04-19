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
    
    var window: UIWindow?
    
    override func setUp() {
        super.setUp()
        vc = ViewController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        //let homeController = HomeController(collectionViewLayout: UICollectionViewFlowLayout())
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
        brain = vc.graphBrain
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCenterPoint() {
        let view: UIView! = vc.view
        let origin = CGPoint(x: 0, y: 0)
        let increment_Y = view.bounds.maxY/(2*GraphBrain.MAX_Y)
        let increment_X = view.bounds.maxX/(2*GraphBrain.MAX_X)
        
        var i: CGFloat  = 0
        var j: CGFloat = 0
        
        while (i < view.bounds.maxX) {
            while (j < view.bounds.maxY) {
                let point = CGPoint(x: i, y: j)
                let centered = brain.centerPoint(point)
                
                
                XCTAssert(centered.x == (origin.x + i)/GraphBrain.MAX_X, "\(centered.x), \((origin.x + i)/GraphBrain.MAX_X)")
                XCTAssert(centered.y == (origin.y + j)/GraphBrain.MAX_Y, "\(centered.y), \((origin.y + j)/GraphBrain.MAX_Y)")
                j += increment_Y
            }
            i += increment_X
        }
        XCTAssert(true)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
