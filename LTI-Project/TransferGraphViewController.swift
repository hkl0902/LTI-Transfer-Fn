//
//  TransferGraphViewController.swift
//  LTI-Project
//
//  Created by Hyunkyu Lee on 4/19/17.
//  Copyright © 2017 Hyunkyu Lee. All rights reserved.
//

import UIKit

class TransferGraphViewController: UIViewController {
    
    var transferView: TransferView?
    var calculator: HeuristicCalculator = HeuristicCalculator()
    var points: [GraphView.Point] = [] // In GraphView Coordinates

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        transferView = TransferView(frame: self.view.frame)
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(transferView!)
        transferView?.backgroundColor = .white
        calculator.roots = points
        calculator.maxX = self.view.frame.maxX// because we're landscape
        calculator.midX = self.view.frame.maxX/2
        transferView?.pointsToDraw = calculator.getPoints()
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class HeuristicCalculator {
    var roots: [GraphView.Point] = []
    var unitCirclePoints: [CGPoint] = []
    let N: CGFloat = 100
    
    var maxX: CGFloat = 1
    var midX: CGFloat = 1
    
    func getPoints() -> [CGPoint] { // Returns points to draw on the transfer graph
        // first make some heuristic
        var pointsToDraw = [CGPoint]()
        for i in 0..<Int(N) {
            let p = CGPoint(x: cos(CGFloat.pi*2.0/CGFloat(N)*CGFloat(i)), y: sin(CGFloat.pi*2/CGFloat(N)*CGFloat(i)))
            unitCirclePoints.append(p)
        }
        
        for i in 0..<Int(N) {
            // create points in view Coordinates
            let x = (maxX/N*CGFloat(i))
            let y = findHeuristic(from: unitCirclePoints[i])
            pointsToDraw.append(CGPoint(x: x, y: y))
            
        }
        //return [CGPoint(x: 0, y: 0), CGPoint(x: 50, y:100), CGPoint(x: 100, y:75), CGPoint(x: 150, y:400)]
        //print(pointsToDraw)
        return pointsToDraw
    }
    
    private func findHeuristic(from unitCirclePoint: CGPoint) -> CGFloat {
        var heuristic: CGFloat = 1
        for root in roots {
            switch root {
            case .Zero(let zero):
                let dx = unitCirclePoint.x - zero.x
                let dy = unitCirclePoint.y - zero.y
                heuristic -= (dx*dx)*dx*dx + dy*dy*dy*dy
            case .Pole(let pole):
                let dx = unitCirclePoint.x - pole.x
                let dy = unitCirclePoint.y - pole.y
                heuristic += dx*dx*dx*dx + dy*dy*dy*dy
            }
        }
        return heuristic
    }
}
