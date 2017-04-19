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
    
    // All the poles and zeros (properly centered)
    var poles: [CGPoint]
    var zeros: [CGPoint]
    var view: UIView
    
    init(view: UIView) {
        poles = []
        zeros = []
        self.view = view
    }
    
    func addPole(pole: CGPoint) {
        poles += [centerPoint(pole)]
    }
    
    func addZero(zero: CGPoint) {
        zeros += [centerPoint(zero)]
    }
    
    // Centers a point given the superview
    private func centerPoint(_ point: CGPoint) -> CGPoint {
        let midX = view.bounds.midX
        let midY = view.bounds.midY
        // TODO: Correct the scaling
        return CGPoint(x: point.x + midX, y: point.y + midY)
    }
    
}
