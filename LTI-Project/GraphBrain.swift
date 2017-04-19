//
//  GraphBrain.swift
//  LTI-Project
//
//  Created by Hyunkyu Lee on 4/18/17.
//  Copyright © 2017 Hyunkyu Lee. All rights reserved.
//

import Foundation
import UIKit

class GraphBrain {
    
    static let MAX_Y: CGFloat = 5
    static let MAX_X: CGFloat = 5
    
    // All the poles and zeros (properly centered)
    var poles: [CGPoint] = []
    var zeros: [CGPoint] = []
    var view: UIView?
    
    func addPole(pole: CGPoint) {
        poles += [centerPoint(pole)]
    }
    
    func addZero(zero: CGPoint) {
        zeros += [centerPoint(zero)]
    }
    
    // Centers a point given the superview
    // point: the result of a touch or click on the surface
    // @return: the x and y value of that point given the above maxY/maxX
    private func centerPoint(_ point: CGPoint) -> CGPoint {
        guard let view = view else { return CGPoint(x: 0, y: 0) } 
        let midX = view.bounds.midX
        let midY = view.bounds.midY
        
        // TODO: Correct the scaling
        return CGPoint(x: (point.x - midX)/GraphBrain.MAX_X, y: (point.y - midY)/GraphBrain.MAX_Y)
    }
    
}
