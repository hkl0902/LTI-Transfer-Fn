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
    
    func testPolynomial() {
        let p = Polynomial()
        let q = Polynomial()
        
        // (x-1/2)(x+1/2) = x^2-1/4
        
        // test 1
        p.coefficients = [0:(-0.5, 0), 1:(1.0, 0)]
        q.coefficients = [0:(0.5, 0), 1:(1.0, 0)]
        
        p.multiplyPolynomial(q)
        
        var pCoeff = p.coefficients
        
        XCTAssert(pCoeff[0]! == (-0.25, 0))
        XCTAssert(pCoeff[1]! == (0, 0))
        XCTAssert(pCoeff[2]! == (1, 0))
        
        // (x^2-1/4)(x-Float(3)*sqrt(3))
        // = x^3 - Float(3)*sqrt(3) x^2 - x/4 + 3(sqrt(3))/4
        
        // test 2
        
        q.coefficients = [0:(-Float(3)*sqrt(3), 0), 1:(1, 0)]
        p.multiplyPolynomial(q)
        
        pCoeff = p.coefficients
        
        XCTAssert(pCoeff[0]! == (Float(3)*sqrt(3)/4, 0))
        XCTAssert(pCoeff[1]! == (-1/4, 0))
        XCTAssert(pCoeff[2]! == (-Float(3)*sqrt(3), 0))
        XCTAssert(pCoeff[3]! == (1, 0))
        
        // [x^3 - Float(3)*sqrt(3) x^2 - x/4 + 3(sqrt(3))/4](x-(-1+3i))
//         = x^4 - 3 sqrt(3) x^3 + (1 - 3 i) x^3 - (3 - 9 i) sqrt(3) x^2
//           - x^2/4 + (3 sqrt(3) x)/4 - (1/4 - (3 i)/4) x
//           + (3/4 - (9 i)/4) sqrt(3)
        
        // test 3
        
        q.coefficients = [0:(1, -3), 1:(1, 0)]
        p.multiplyPolynomial(q)
        
        pCoeff = p.coefficients
        
        XCTAssert(pCoeff[0]!.0 == (Float(3)*sqrt(3)/4))
        XCTAssert(pCoeff[0]!.1 == -9/Float(4)*sqrt(3))
        XCTAssert(4*pCoeff[1]!.0 == (Float(3)*1.732050808-1))
        XCTAssert(pCoeff[1]!.1 == 0.75, "got: \(pCoeff[1]!.1), expected: \(0.75)")
        XCTAssert(pCoeff[2]!.0 == -Float(3)*1.732050808-0.25)
        XCTAssert(pCoeff[2]!.1 == Float(9)*sqrt(3))
        XCTAssert(pCoeff[3]!.0 == -Float(3)*1.732050808+1)
        XCTAssert(pCoeff[3]!.1 == -3)
        XCTAssert(pCoeff[4]!.0 == 1)
        XCTAssert(pCoeff[4]!.1 == 0)
//
//        // above * x
//        // x^5 - 3 sqrt(3) x^4 + (1 - 3 i) x^4 - (3 - 9 i) sqrt(3) x^3
//        // - x^3/4 + (3 sqrt(3) x^2)/4 - (1/4 - (3 i)/4) x^2 +
//        // (3/4 - (9 i)/4) sqrt(3) x
//        
//        // test 4
//        
       q.coefficients = [1:(1,0), 0:(0, 0)]
       p.multiplyPolynomial(q)
       pCoeff = p.coefficients
       
       XCTAssert(pCoeff[0]!.0 == 0)
       XCTAssert(pCoeff[0]!.1 == 0)
       XCTAssert(pCoeff[1]!.0 == Float(3)*sqrt(3)/4)
       XCTAssert(pCoeff[1]!.1 == -9/Float(4)*1.732050808)
       XCTAssert(4*pCoeff[2]!.0 == (Float(3)*1.732050808-1));
        XCTAssert(pCoeff[2]!.1 == 0.75, "got: \(pCoeff[2]!.1), expected: \(0.75)")
       XCTAssert(pCoeff[3]!.0 == -Float(3)*1.732050808-0.25)
       XCTAssert(pCoeff[3]!.1 == Float(9)*1.732050808)
       XCTAssert(pCoeff[4]!.0 == -Float(3)*1.732050808+1)
       XCTAssert(pCoeff[4]!.1 == -3)
       XCTAssert(pCoeff[5]!.0 == 1)
       XCTAssert(pCoeff[5]!.1 == 0)
        print("Success")
    }
    
    func testToStringPoly() {
        let p = Polynomial()
        p.coefficients = [0:(1, 0), 1:(1, 2), 3:(2, 4)]
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

import Foundation
import Darwin

class Polynomial {
    var coefficients = [Int:(Float, Float)]()    // coefficients in terms of power
    // power:coefficient
    
    // Destructively multiplies self with another polynomial
    func multiplyPolynomial(_ Q: Polynomial) {
        var newCoefficients = [Int: (Float, Float)]()
        
        for (pPower, (pR, pI)) in coefficients {
            for (qPower, (qR, qI)) in Q.coefficients {
                let multipliedPower = pPower + qPower
                let prodR = Float(pR*qR) - Float(pI*qI)
                let prodI = Float(pR*qI) + Float(pI*qR)
                if let (currCoeffR, currCoeffI) = newCoefficients[multipliedPower]  {
                    newCoefficients[multipliedPower] = (currCoeffR + prodR, currCoeffI + prodI)
                } else {
                    newCoefficients[multipliedPower] = (prodR, prodI)
                }
            }
        }
        
        self.coefficients = newCoefficients
    }
}



