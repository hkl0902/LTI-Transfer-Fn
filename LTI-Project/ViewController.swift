//
//  ViewController.swift
//  LTI-Project
//
//  Created by Hyunkyu Lee on 4/13/17.
//  Copyright © 2017 Hyunkyu Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var graph: GraphView?
    var graphBrain: GraphBrain = GraphBrain()
    
    var addZeroButton: UIBarButtonItem?
    var addPoleButton: UIBarButtonItem?
    var solveButton: UIBarButtonItem?
    var clearButton: UIBarButtonItem?
    
    var demoButtons: [UIBarButtonItem] = [UIBarButtonItem]()
    
    var poleEnabled = false
    var zeroEnabled = true
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addZeroButton = UIBarButtonItem(title: "Zero", style: .plain, target: self, action: #selector(ViewController.enableZero))
        self.addPoleButton = UIBarButtonItem(title: "Pole", style: .plain, target: self, action: #selector(ViewController.enablePole))
        self.solveButton = UIBarButtonItem(title: "Solve", style: .done, target: self, action: #selector(ViewController.solve))
        self.clearButton = UIBarButtonItem(title: "Clear", style: .done, target: self, action: #selector(ViewController.clearPoints))
        
        // Some Demo Items
        
        self.demoButtons.append(UIBarButtonItem(title: "3", style: .plain, target: self, action: #selector(ViewController.demo3)))
        self.demoButtons.append(UIBarButtonItem(title: "2", style: .plain, target: self, action: #selector(ViewController.demo2)))
        self.demoButtons.append(UIBarButtonItem(title: "1", style: .plain, target: self, action: #selector(ViewController.demo1)))
        
        //
        
        self.navigationItem.leftBarButtonItems = [addZeroButton!, addPoleButton!]
        self.navigationItem.rightBarButtonItems = [solveButton!, clearButton!] + self.demoButtons
        let tapGestureRecgonizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.touchInput(gestureRecognizer:)))
        self.view.addGestureRecognizer(tapGestureRecgonizer)
    }
    
    func clearPoints() {
        self.graph?.points.removeAll()
        self.graphBrain.poles.removeAll()
        self.graphBrain.zeros.removeAll()
    }
    
    func enableZero() {
        zeroEnabled = true
        poleEnabled = false
        updateButtons()
    }
    
    func enablePole() {
        poleEnabled = true
        zeroEnabled = false
        updateButtons()
    }
    
    func updateButtons() {
        if zeroEnabled {
            self.addZeroButton?.tintColor = .gray
        }
        if poleEnabled {
            self.addPoleButton?.tintColor = .gray
        }
    }
    
    func demo1() {
        clearPoints()
        zeroEnabled = true
        var point = CGPoint(x: -1, y: 0.5)
        addPoint(graphBrain.getViewPoint(point))
        point = CGPoint(x: 1, y: 0)
        addPoint(graphBrain.getViewPoint(point))
        zeroEnabled = false
        poleEnabled = true
        point = CGPoint(x: 0.2, y: 0)
        addPoint(graphBrain.getViewPoint(point))
    }
    
    func demo2() {
        clearPoints()
    }
    
    func demo3() {
        clearPoints()
    }
    
    func addPoint(_ loc: CGPoint) {
        if zeroEnabled {
            graph?.points.append(GraphView.Point.Zero(loc))
            graphBrain.addZero(zero: loc)
            guard let conjugate = graphBrain.getConjugate(loc) else { return }
            graph?.points.append(GraphView.Point.Zero(conjugate))
            graphBrain.addZero(zero: conjugate)
        } else {
            graph?.points.append(GraphView.Point.Pole(loc))
            graphBrain.addPole(pole: loc)
            guard let conjugate = graphBrain.getConjugate(loc) else { return }
            graph?.points.append(GraphView.Point.Pole(conjugate))
            graphBrain.addPole(pole: conjugate)
        }
    }

    
    func touchInput(gestureRecognizer: UITapGestureRecognizer) {
        let touched = gestureRecognizer.location(in: self.view)
        
        // rounding
        let loc = graphBrain.roundedLoc(touched)
        
        addPoint(loc)
    }
    
    func solve() {
        let solver = SolverViewController()
        var points: [GraphView.Point] = [] // Convert all points to graphView Coordinates
        if let graphPoints = graph?.points {
            for point in graphPoints {
                switch point {
                case .Zero(let zero):
                    let convertedPoint = GraphView.Point.Zero(graphBrain.getGraphPoint(zero))
                    points.append(convertedPoint)
                case .Pole(let pole):
                    let convertedPoint = GraphView.Point.Pole(graphBrain.getGraphPoint(pole))
                    points.append(convertedPoint)
                }
                
            }
            solver.points = points        // todo
            self.navigationController?.pushViewController(solver, animated: true)
        }
    }
    
    override func viewWillLayoutSubviews() {
        self.view.backgroundColor = .white
        print(self.view.frame)
        graph = GraphView(frame: self.view.bounds)
        graphBrain.view = self.view
        // set radius
        let angle0 = graphBrain.getViewPoint(CGPoint(x: 1, y: 0))
        let radius = angle0.x - self.view.bounds.midX
        graph?.unitCircleRadius = radius     // set radius
        self.view.addSubview(graph!)
        graph?.backgroundColor = UIColor.white
        graph?.setNeedsDisplay()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

