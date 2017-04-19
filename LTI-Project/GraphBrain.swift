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
    static let MAX_X: CGFloat = 10
    
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
    func centerPoint(_ point: CGPoint) -> CGPoint {
        guard let view = view else { return CGPoint(x: 0, y: 0) } 
        let midX = view.bounds.midX
        let midY = view.bounds.midY
        let maxX = view.bounds.maxX
        let maxY = view.bounds.maxY
        
        // TODO: Correct the scaling
        return CGPoint(x: (point.x - midX)*GraphBrain.MAX_X/maxX*2, y: -(point.y - midY)*GraphBrain.MAX_Y/maxY*2)
    }
    
    
    // given a point in the coordinate system, returns the coordinates in the view coordinate system
    func getLocation(_ point: CGPoint) {
        let maxX = view.bounds.maxX
        let maxY = view.bounds.maxY
        let midX = view.bounds.midX
        let midY = view.bounds.midY
        return CGPoint(x: point/2*maxX/GraphBrain.MAX_X + midX, y: -y/2*maxY/GraphBrain.MAX_Y + midY)
    }
    
}
