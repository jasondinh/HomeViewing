//
//  ViewController.swift
//  HomeViewing
//
//  Created by Jason on 5/8/17.
//  Copyright © 2017 TinyWhale. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import SnapKit
class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        // Do any additional setup after loading the view, typically from a nib.
        let mainViewController = MainViewController()
        self.view.addSubview(mainViewController.view)
        self.addChildViewController(mainViewController)
        mainViewController.view.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
