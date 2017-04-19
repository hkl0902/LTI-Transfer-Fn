//
//  GraphView.swift
//  LTI-Project
//
//  Created by Hyunkyu Lee on 4/18/17.
//  Copyright © 2017 Hyunkyu Lee. All rights reserved.
//

import UIKit
import Foundation

class GraphView: UIView {
    
    var yAxis: UIBezierPath?
    var xAxis: UIBezierPath?
    var unitCircle: UIBezierPath?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        let midY = self.bounds.midY
        let midX = self.bounds.midX
        let maxX = self.bounds.maxX
        let minX = self.bounds.minX
        let maxY = self.bounds.maxY
        let minY = self.bounds.minY
        // yaxis
        yAxis = UIBezierPath()
        yAxis?.move(to: CGPoint(x: midX, y: minY))
        yAxis?.addLine(to: CGPoint(x: midX, y: maxY))
        UIColor.black.setFill()
        UIColor.black.setStroke()
        yAxis?.lineWidth = 1
        yAxis?.stroke()
        yAxis?.fill()
        yAxis?.close()
        // xaxis
        xAxis = UIBezierPath()
        xAxis?.move(to: CGPoint(x: minX, y: midY))
        xAxis?.addLine(to: CGPoint(x: maxX, y: midY))
        UIColor.black.setFill()
        UIColor.black.setStroke()
        xAxis?.lineWidth = 1
        xAxis?.stroke()
        xAxis?.fill()
        xAxis?.close()
        // unit cricle
        unitCircle = UIBezierPath(arcCenter: CGPoint(x: midX, y: midY), radius: midX/10, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        UIColor.red.withAlphaComponent(0.5).setStroke()
        unitCircle?.lineWidth = 1
        unitCircle?.setLineDash(nil, count: 30, phase: 0)
        unitCircle?.stroke()
        unitCircle?.close()
    }
    
    private func drawPole(center: CGPoint) {
        let path = UIBezierPath()
        //path.move(to: center)
        let xL = center.x + 5*cos(CGFloat.pi/4.0 * 3)
        let yT  = center.y + 5*sin(CGFloat.pi/4.0*3)
        let xR = center.x + 5*cos(-CGFloat.pi/4)
        let yD = center.x + 5*sin(-CGFloat.pi/4)

        let topLeft = CGPoint(x: xL, y: yT)
        let topRight = CGPoint(x: xR, y: yT)
        let bottomLeft = CGPoint(x: xL, y: yD)
        let bottomRight = CGPoint(x: xR, y: yD)

        path.move(to: topLeft)
        path.addLine(to: bottomRight)
        UIColor.black.setStroke()
        path.stroke()
        path.close()

        path.move(to: bottomLeft)
        path.addLine(to: topRight)
        path.stroke()
        path.close()

        return;
    }
    
    private func drawZero(center: CGPoint) {
        let path = UIBezierPath(arcCenter: center, radius: 3, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        UIColor.black.setStroke()
        path.stroke()
        path.close()
        return;
    }
    
}
