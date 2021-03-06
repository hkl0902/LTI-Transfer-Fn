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
    
    // Not necessary in GraphViewCoordinates
    enum Point {
        case Zero(CGPoint)
        case Pole(CGPoint)
    }
    
    var yAxis: UIBezierPath?
    var xAxis: UIBezierPath?
    var unitCircle: UIBezierPath?
    var unitCircleRadius: CGFloat?
    
    var points: [Point] = [] {      // TODO: separate this out for more mvc code
        didSet {
            self.setNeedsDisplay()
        }
    }// These are the poles and zeros
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        drawYAxis()
        drawXAxis()
        drawUnitCircle()
        drawPoints()
    }
    
    private func drawPoints() {
        UIColor.black.setStroke()
        for point in points {
            switch point {
            case Point.Pole(let pole):
                drawPole(center: pole)
            case Point.Zero(let zero):
                drawZero(center: zero)
            }
        }
    }
    
    private func clearPoints() {
        points.removeAll()
        
    }
    
    private func drawYAxis() {
        let midX = self.bounds.midX
        let maxY = self.bounds.maxY
        let minY = self.bounds.minY
        yAxis = UIBezierPath()
        yAxis?.move(to: CGPoint(x: midX, y: minY))
        yAxis?.addLine(to: CGPoint(x: midX, y: maxY))
        UIColor.black.setFill()
        UIColor.black.setStroke()
        yAxis?.lineWidth = 1
        yAxis?.stroke()
        yAxis?.fill()
        yAxis?.close()
    }
    
    private func drawXAxis() {
        let midY = self.bounds.midY
        let maxX = self.bounds.maxX
        let minX = self.bounds.minX
        xAxis = UIBezierPath()
        xAxis?.move(to: CGPoint(x: minX, y: midY))
        xAxis?.addLine(to: CGPoint(x: maxX, y: midY))
        UIColor.black.setFill()
        UIColor.black.setStroke()
        xAxis?.lineWidth = 1
        xAxis?.stroke()
        xAxis?.fill()
        xAxis?.close()
    }
    
    private func drawUnitCircle() {
        let radius = unitCircleRadius ?? 0
        let midY = self.bounds.midY
        let midX = self.bounds.midX
        unitCircle = UIBezierPath(arcCenter: CGPoint(x: midX, y: midY), radius: radius, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        UIColor.red.withAlphaComponent(0.5).setStroke()
        unitCircle?.lineWidth = 1
        unitCircle?.setLineDash(nil, count: 30, phase: 0)
        unitCircle?.stroke()
        unitCircle?.close()
    }
    
    // The center should be "centered"
    
    func drawPole(center: CGPoint) {
        let path = UIBezierPath()
        //path.move(to: center)
        let xL = center.x + 5*cos(CGFloat.pi/4.0 * 3)
        let yT  = center.y + 5*sin(CGFloat.pi/4.0*3)
        let xR = center.x + 5*cos(-CGFloat.pi/4)
        let yD = center.y + 5*sin(-CGFloat.pi/4)

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
    
    // The center should be "centered"
    
    func drawZero(center: CGPoint) {
        let path = UIBezierPath(arcCenter: center, radius: 3, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        UIColor.black.setStroke()
        path.stroke()
        path.close()
        return;
    }    
}
