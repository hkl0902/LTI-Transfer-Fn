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
    
    var poleEnabled = false
    var zeroEnabled = true
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addZeroButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ViewController.enableZero))
        self.addPoleButton = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: #selector(ViewController.enablePole))
        self.navigationItem.leftBarButtonItems = [addZeroButton!, addPoleButton!]
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
            graph?.drawZero(center: loc)
            graphBrain.addZero(zero: loc)
        } else {
            graph?.drawPole(center: loc)
            graphBrain.addPole(pole: loc)
        }
        
        
        
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

