//
//  GraphBrain.swift
//  LTI-Project
//
//  Created by Hyunkyu Lee on 4/18/17.
//  Copyright © 2017 Hyunkyu Lee. All rights reserved.
//

import Foundation
import UIKit
import Darwin

class GraphBrain {
    
    static let MAX_Y: CGFloat = 5
    static let MAX_X: CGFloat = 10
    static let ROUND_TO: CGFloat = 10 // must be less than 1
    
    // All the poles and zeros (properly centered)
    var poles: [CGPoint] = []
    var zeros: [CGPoint] = []
    var view: UIView?
    
    func addPole(pole: CGPoint) {
        poles += [getGraphPoint(pole)]
    }
    
    func addZero(zero: CGPoint) {
        zeros += [getGraphPoint(zero)]
    }
    
    // Centers a point given the superview
    // point: the result of a touch or click on the surface (the viewPoint)
    // @return: the x and y value of that point given the above maxY/maxX (the graphPoint)
    func getGraphPoint(_ point: CGPoint) -> CGPoint {
        guard let view = view else { return CGPoint(x: 0, y: 0) } 
        let midX = view.bounds.midX
        let midY = view.bounds.midY
        let maxX = view.bounds.maxX
        let maxY = view.bounds.maxY
        
        // TODO: Correct the scaling
        return CGPoint(x: (point.x - midX)*GraphBrain.MAX_X/maxX*2, y: -(point.y - midY)*GraphBrain.MAX_Y/maxY*2)
    }
    
    
    // given a graphPoint, returns the viewPoint
    func getViewPoint(_ point: CGPoint) -> CGPoint {
        guard let view = view else { return CGPoint(x: 0, y: 0) }
        let maxX = view.bounds.maxX
        let maxY = view.bounds.maxY
        let midX = view.bounds.midX
        let midY = view.bounds.midY
        return CGPoint(x: point.x/2*maxX/GraphBrain.MAX_X + midX, y: -point.y/2*maxY/GraphBrain.MAX_Y + midY)
    }
    
    // Given a viewPoint, returns the conjugate in viewPoint; nil if the conjugate is the same as the original point
    func getConjugate(_ point: CGPoint) -> CGPoint? {
        let centered = getGraphPoint(point)
        if centered.y == 0 {
            return nil
        }
        let conjugate = CGPoint(x: centered.x, y: -centered.y)
        return getViewPoint(conjugate)
    }
    
    
    //  Given a viewPoint, returns a viewPoint whose dimensios are rounded
    func roundedLoc(_ point: CGPoint) -> CGPoint {
        guard let view = view else { return CGPoint(x: 0, y: 0) }
        let midX = view.bounds.midX
        let midY = view.bounds.midY
        var roundedX = round(point.x/GraphBrain.ROUND_TO) * GraphBrain.ROUND_TO
        var roundedY = round(point.y/GraphBrain.ROUND_TO) * GraphBrain.ROUND_TO
        
        if abs(roundedX - midX) < 10 {
            roundedX = midX
        }
        if abs(roundedY - midY) < 10 {
            roundedY = midY
        }
        
        // Check if near unit circle by distance
        let graphPoint = getGraphPoint(CGPoint(x: roundedX, y: roundedY))
        if abs(graphPoint.x*graphPoint.x + graphPoint.y*graphPoint.y - 1) < 0.5 {
            let angle0 = self.getViewPoint(CGPoint(x: 1, y: 0))
            let radius = angle0.x - midX
            var angle = 0.0
            if graphPoint.x != 0 {
                angle = atan(Double(graphPoint.y/graphPoint.x))
            } else {
                let y = getGraphPoint(point).y
                if y > 0 {
                    angle = Double.pi/2.0
                } else {
                    angle = -Double.pi/2.0
                }
            }
            
            // account for tan range
            if graphPoint.x < 0 {
                angle = Double.pi - angle
            }
            
            roundedX = radius*cos(CGFloat(angle)) + midX
            roundedY = -radius*sin(CGFloat(angle)) + midY
        }
        
        return CGPoint(x: roundedX, y: roundedY)
    }
    
}
