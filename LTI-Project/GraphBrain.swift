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
    
    var poles: [CGPoint]?
    var zeros: [CGPoint]?
    
    init() {
        poles = []
        zeros = []
    }
    
    // Centers a point given the superview
    private func centerPoint(point: CGPoint, view: UIView) -> CGPoint {
        let midX = view.bounds.midX
        let midY = view.bounds.midY
        // TODO: Correct the scaling
        return CGPoint(x: point.x + midX, y: point.y + midY)
    }
    
}
