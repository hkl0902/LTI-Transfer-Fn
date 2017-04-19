//
//  SolverViewController.swift
//  LTI-Project
//
//  Created by Hyunkyu Lee on 4/19/17.
//  Copyright © 2017 Hyunkyu Lee. All rights reserved.
//

import UIKit

class SolverViewController: UIViewController {

    var solverView: SolverView?
    
    var points: [GraphView.Point] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        solverView = SolverView(frame: self.view.frame)
        self.view.addSubview(solverView!)
        solverView?.backgroundColor = .yellow
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
