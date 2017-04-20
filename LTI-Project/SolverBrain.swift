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
    
    var roots: [GraphView.Point] = [] // all points are in ios coordinate system, must be centered
    let numeratorPolynomial = Polynomial()
    let denominatorPolynomial = Polynomial() 
    
    // Returns a list of the coeficients of the polynomials in the numerator/denominator
    func transferFunction() -> (numerator: Polynomial, denominator: Polynomial){
        var zeros: [CGPoint] = [] // roots in numerator
        var poles: [CGPoint] = [] // roots in denominator
        
        for point in roots {
            switch point {
            case .Pole(let pole):
                poles += [pole]
            case .Zero(let zero):
                zeros += [zero]
            }
        }
        
        numeratorPolynomial.coefficients = [0:(1, 0)]
        denominatorPolynomial.coefficients = [0:(1, 0)]
        // Go from zeros/poles into a long polynomial of z^{-n}
        // initializeNumerator
        
        for zero in zeros {
            let p = Polynomial()
            p.coefficients = [0:(-Float(zero.x), -Float(zero.y)), 1:(1.0, 0)] // x - zero
            numeratorPolynomial.multiplyPolynomial(p)
        }
        
        // initializeDenominator
        
        for pole in poles {
            let p = Polynomial()
            p.coefficients = [0:(-Float(pole.x), -Float(pole.y)), 1:(1.0, 0)] // x - zero
            denominatorPolynomial.multiplyPolynomial(p)
        }

        // TODO get correct value
        return (Polynomial(), Polynomial())
    }
    
    // func get difference equation
    func getDifferenceEquation() -> (String, String) {
        // numerator gives coeff for x
        // denom gives coeff for y
        let xStr = polyToString(polynomial: numeratorPolynomial, "x")
        let yStr = polyToString(polynomial: denominatorPolynomial, "y")
        return (xStr, yStr)
    }
    
    private func polyToString(polynomial: Polynomial, _ variable: Character) -> String {
        let sortedKeys = Array(polynomial.coefficients.keys).sorted()
        var strRepr = ""
        for power in sortedKeys {
            if let coeff = polynomial.coefficients[power] {
                if coeff.0 != 0 {
                    strRepr += " \(coeff.0)\(variable)[n"
                    if power < 0 {
                        strRepr += " - \(power)] +"
                    } else if power > 0 {
                        strRepr += " + \(power)] +"
                    } else {
                        strRepr += "] +"
                    }
                }
            }
        }
        strRepr.remove(at: strRepr.index(before: strRepr.endIndex))
        strRepr.remove(at: strRepr.startIndex)
        return strRepr
    }
}

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
