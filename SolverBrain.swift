//
//  SolverBrain.swift
//  LTI-Project
//
//  Created by Hyunkyu Lee on 4/19/17.
//  Copyright © 2017 Hyunkyu Lee. All rights reserved.
//

import Foundation
import UIKit

class Solver {
    
    var points: [GraphView.Point] = [] // all points are in ios coordinate system, must be centered
    
    // Returns a list of the coeficients of the polynomials in the numerator/denominator
    func transferFunction() -> (numerator: [CGFloat], denominator: [CGFloat]){
        var zeros: [CGPoint] = [] // roots in numerator
        var poles: [CGPoint] = [] // roots in denominator
        
        for point in points {
            switch point {
            case .Pole(let pole):
                poles += [pole]
            case .Zero(let zero):
                zeros += [zero]
            }
        }
        
        var numeratorPolynomials    = [Polynomial]()
        var denominatorPolynomials  = [Polynomial]()
        // Go from zeros/poles into a long polynomial of z^{-n}
        // initializeNumerator
        
        
        for zero in zeros {
            var p = Polynomial()
            p.coefficients = [0:(-Float(zero.x), -Float(zero.y)), 1:(1.0, 0)] // x - zero
        }
        
        // initializeDenominator
        
        
        
        for pole in poles {
            var p = Polynomial()
            p.coefficients = [0:(-Float(pole.x), -Float(pole.y)), 1:(1.0, 0)] // x - zero
        }
        
        
        
        // multiply poles
        // multiply zeros
        return ([0], [0])
    }
    
    // func get difference equation
    
}

class Polynomial {
    var coefficients = [Int:(Float, Float)]()    // coefficients in terms of power
                                // power:coefficient
    
    // Destructively multiplies self with another polynomial
    func multiplyPolynomial(Q: Polynomial) {
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
