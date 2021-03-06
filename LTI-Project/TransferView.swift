//
//  TransferView.swift
//  LTI-Project
//
//  Created by Hyunkyu Lee on 4/19/17.
//  Copyright © 2017 Hyunkyu Lee. All rights reserved.
//

import UIKit
import Darwin
import Foundation

class TransferView: UIView {

    var yAxis: UIBezierPath?
    var xAxis: UIBezierPath?
    var navigationHeight: CGFloat = 0
    var xAxisHeight: CGFloat = 20
    var pointsToDraw = [CGPoint]() {
        didSet {
            setNeedsDisplay()
        }
    }// points should be ordered by x value and should be of ViewPoint
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        drawYAxis()
        drawXAxis()
        //pointsToDraw = [ CGPoint(x: 0, y: 0), CGPoint(x: 50, y:100), CGPoint(x: 100, y:75), CGPoint(x: 150, y:400)]
        let scaledPoints = scale(pointsToDraw)
        drawPoints(scaledPoints)
    }
    
    // points in ViewCoordinates
    // larger value means higher down :) 
    // I want the largest values to at most be maxY - xAxis and I want to minimum values to be at least navigation Height
    private func scale(_ points: [CGPoint]) -> [CGPoint] {
        var scaledPoints = [CGPoint]()
        let maxY = self.bounds.maxY - xAxisHeight
        let minY = navigationHeight
        //let xAxis = maxY-20
        let yPoints = points.map() {
            return Float($0.y)
        }
        var minimum = CGFloat(yPoints.reduce(yPoints[0]) {
            return min($0, $1)
        })
        
        let maximum = CGFloat(yPoints.reduce(yPoints[0]) {
            return max($0, $1)
        })
        // remember than if my y is large => i have to scale it to be small
        if minimum < 0 {
            minimum = -minimum
        }
        
        for p in points {
            var scaledY = p.y + minimum + minY
            scaledY = scaledY * CGFloat(maxY/(maximum + minimum + minY))
            scaledPoints.append(CGPoint(x: p.x, y: scaledY))
        }
        return scaledPoints
    }
    
    private func drawXAxis() {

        let maxX = self.bounds.maxX
        let minX = self.bounds.minX
        let midX = self.bounds.midX
        let maxY = self.bounds.maxY
        xAxis = UIBezierPath()
        xAxis?.move(to: CGPoint(x: minX, y: maxY-xAxisHeight))
        xAxis?.addLine(to: CGPoint(x: maxX, y: maxY-xAxisHeight))
        UIColor.black.setFill()
        UIColor.black.setStroke()
        xAxis?.lineWidth = 1
        xAxis?.stroke()
        xAxis?.fill()
        xAxis?.close()
        
        // Draw tick marks
        
        xAxis?.move(to: CGPoint(x: 0, y: maxY-xAxisHeight+10))
        xAxis?.addLine(to: CGPoint(x: 0, y: maxY-xAxisHeight-10))
        xAxis?.stroke()
        xAxis?.close()
        
        xAxis?.move(to: CGPoint(x: midX/2, y: maxY-xAxisHeight+10))
        xAxis?.addLine(to: CGPoint(x: midX/2, y: maxY-xAxisHeight-10))
        xAxis?.stroke()
        xAxis?.close()

        xAxis?.move(to: CGPoint(x: midX*3/2, y: maxY-xAxisHeight+10))
        xAxis?.addLine(to: CGPoint(x: midX*3/2, y: maxY-xAxisHeight-10))
        xAxis?.stroke()
        xAxis?.close()
        
        xAxis?.move(to: CGPoint(x: midX*2, y: maxY-xAxisHeight+10))
        xAxis?.addLine(to: CGPoint(x: midX*2, y: maxY-xAxisHeight-10))

        xAxis?.stroke()
        xAxis?.close()
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
    
    func drawPoints(_ points: [CGPoint]) {
        let transferFnPath = UIBezierPath()
        var prevPoint: CGPoint?
        for point in points {
            if let _ = prevPoint {
                transferFnPath.addLine(to: point)
            } else {
                prevPoint = point
                transferFnPath.move(to: point)
            }
        }
        if points.count > 0 {
            UIColor.blue.setStroke()
            transferFnPath.stroke()
            transferFnPath.close()
        }
    }

}
