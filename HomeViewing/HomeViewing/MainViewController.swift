//
//  MainViewController.swift
//  HomeViewing
//
//  Created by Jason on 5/8/17.
//  Copyright © 2017 TinyWhale. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var tabBar:UITabBar?
    var cameraViewController:CameraViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar = UITabBar(frame: .zero)
        self.cameraViewController = CameraViewController()
        if let tabBar = self.tabBar,
            let cameraViewController = self.cameraViewController {
            self.view.addSubview(tabBar)
            tabBar.snp.makeConstraints({ (make) in
                make.left.equalTo(self.view)
                make.width.equalTo(self.view)
                make.bottom.equalTo(self.view)
            })
            
            self.view.addSubview(cameraViewController.view)
            
            cameraViewController.view.snp.makeConstraints({ (make) in
                make.left.equalTo(self.view)
                make.right.equalTo(self.view)
                make.top.equalTo(self.view)
                make.bottom.equalTo(tabBar.snp.top)
            })
        }
    }
}
