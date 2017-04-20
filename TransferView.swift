//
//  TransferView.swift
//  LTI-Project
//
//  Created by Hyunkyu Lee on 4/19/17.
//  Copyright © 2017 Hyunkyu Lee. All rights reserved.
//

import UIKit

class TransferView: UIView {

    var yAxis: UIBezierPath?
    var xAxis: UIBezierPath?
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        drawYAxis()
        drawXAxis()
    }
    
    private func drawXAxis() {
        let midY = self.bounds.midY
        let maxX = self.bounds.maxX
        let minX = self.bounds.minX
        let midX = self.bounds.midX
        let maxY = self.bounds.maxY
        xAxis = UIBezierPath()
        xAxis?.move(to: CGPoint(x: minX, y: maxY-20))
        xAxis?.addLine(to: CGPoint(x: maxX, y: maxY-20))
        UIColor.black.setFill()
        UIColor.black.setStroke()
        xAxis?.lineWidth = 1
        xAxis?.stroke()
        xAxis?.fill()
        xAxis?.close()
        
        // Draw tick marks
        
        xAxis?.move(to: CGPoint(x: 0, y: maxY-20+10))
        xAxis?.addLine(to: CGPoint(x: 0, y: maxY-20-10))
        xAxis?.stroke()
        xAxis?.close()
        
        xAxis?.move(to: CGPoint(x: midX/2, y: maxY-20+10))
        xAxis?.addLine(to: CGPoint(x: midX/2, y: maxY-20-10))
        xAxis?.stroke()
        xAxis?.close()

        xAxis?.move(to: CGPoint(x: midX*3/2, y: maxY-20+10))
        xAxis?.addLine(to: CGPoint(x: midX*3/2, y: maxY-20-10))
        xAxis?.stroke()
        xAxis?.close()
        
        xAxis?.move(to: CGPoint(x: midX*2, y: maxY-20+10))
        xAxis?.addLine(to: CGPoint(x: midX*2, y: maxY-20-10))

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
        
    }

}
