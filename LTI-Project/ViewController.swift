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
        self.navigationItem.leftBarButtonItems = [addZeroButton!, addPoleButton!]
        self.navigationItem.rightBarButtonItems = [solveButton!]
        let tapGestureRecgonizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.touchInput(gestureRecognizer:)))
        self.view.addGestureRecognizer(tapGestureRecgonizer)
    }
    
    func enableZero() {
        zeroEnabled = true
        poleEnabled = false
    }
    
    func enablePole() {
        poleEnabled = true
        zeroEnabled = false
    }

    
    func touchInput(gestureRecognizer: UITapGestureRecognizer) {
        let loc = gestureRecognizer.location(in: self.view)
        
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
    
    func solve() {
        let solver = SolverViewController()
        self.navigationController?.pushViewController(solver, animated: true)
    }
    
    override func viewWillLayoutSubviews() {
        self.view.backgroundColor = .white
        graph = GraphView(frame: self.view.bounds)
        graphBrain.view = self.view
        self.view.addSubview(graph!)
        graph?.backgroundColor = UIColor.white
        graph?.setNeedsDisplay()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

