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
        
        // Go from zeros/poles into a long polynomial of z^{-n}
        // multiply poles
        // multiply zeros
        return ([0], [0])
    }
    
    // func get difference equation
    
}

