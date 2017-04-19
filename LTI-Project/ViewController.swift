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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecgonizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.touchInput(gestureRecognizer:)))
        self.view.addGestureRecognizer(tapGestureRecgonizer)
    }

    
    func touchInput(gestureRecognizer: UITapGestureRecognizer) {
        let loc = gestureRecognizer.location(in: self.view)
        print("Touch was at: \t \(loc)")
        print("Coord Sys at: \t \(graphBrain.centerPoint(loc))")
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

