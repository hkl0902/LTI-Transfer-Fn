#!/usr/bin/env swift

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

func testPolynomial() {
	let p = Polynomial()
	let q = Polynomial()

	// (x-1/2)(x+1/2) = x^2-1/4

	// test 1
	p.coefficients = [0:(-0.5, 0), 1:(1.0, 0)]
	q.coefficients = [0:(0.5, 0), 1:(1.0, 0)]

	p.multiplyPolynomial(q)

	var pCoeff = p.coefficients

	assert(pCoeff[0]! == (-0.25, 0))
	assert(pCoeff[1]! == (0, 0))
	assert(pCoeff[2]! == (1, 0))

	print("test1")

	// (x^2-1/4)(x-Float(3)*sqrt(3)) 
		// = x^3 - Float(3)*sqrt(3) x^2 - x/4 + 3(sqrt(3))/4

	// test 2

	q.coefficients = [0:(-Float(3)*sqrt(3), 0), 1:(1, 0)]
	p.multiplyPolynomial(q)

	pCoeff = p.coefficients

	assert(pCoeff[0]! == (Float(3)*sqrt(3)/4, 0))
	assert(pCoeff[1]! == (-1/4, 0))
	assert(pCoeff[2]! == (-Float(3)*sqrt(3), 0))
	assert(pCoeff[3]! == (1, 0))

	print("Test2")

	// [x^3 - Float(3)*sqrt(3) x^2 - x/4 + 3(sqrt(3))/4](x-(-1+3i))
		// = x^4 - 3 sqrt(3) x^3 + (1 - 3 i) x^3 - (3 - 9 i) sqrt(3) x^2 
		//   - x^2/4 + (3 sqrt(3) x)/4 - (1/4 - (3 i)/4) x 
		//   + (3/4 - (9 i)/4) sqrt(3)

	// test 3

	q.coefficients = [0:(1, -3), 1:(1, 0)]
	p.multiplyPolynomial(q)

	pCoeff = p.coefficients

	assert(pCoeff[0]! == (Float(3)*sqrt(3)/4, -9/Float(4)*sqrt(3)))
	assert(pCoeff[1]! == (Float(3)*sqrt(3)/4-1/4, -3/4))
	assert(pCoeff[2]! == (-Float(3)*sqrt(3)-1/4, Float(9)*sqrt(3)))
	assert(pCoeff[3]! == (-Float(3)*sqrt(3)+1, -3))
	assert(pCoeff[4]! == (1, 0))

	print("test 3")

	// above * x
		// x^5 - 3 sqrt(3) x^4 + (1 - 3 i) x^4 - (3 - 9 i) sqrt(3) x^3 
		// - x^3/4 + (3 sqrt(3) x^2)/4 - (1/4 - (3 i)/4) x^2 + 
		// (3/4 - (9 i)/4) sqrt(3) x

	// test 4

	q.coefficients = [1:(1,0), 0:(0, 0)]
	p.multiplyPolynomial(q)
	pCoeff = p.coefficients

	assert(pCoeff[0]! == (0, 0))
	assert(pCoeff[1]! == (Float(3)*sqrt(3)/4, -9/Float(4)*sqrt(3)))
	assert(pCoeff[2]! == (Float(3)*sqrt(3)/4-1/4, -3/4))
	assert(pCoeff[3]! == (-Float(3)*sqrt(3)-1/4, Float(9)*sqrt(3)))
	assert(pCoeff[4]! == (-Float(3)*sqrt(3)+1, -3))
	assert(pCoeff[5]! == (1, 0))

	print("test4")
}

testPolynomial()