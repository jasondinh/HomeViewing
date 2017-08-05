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
            
            
            
            let videoItem = UITabBarItem(title: "Video", image: nil, selectedImage: nil)
            let arItem = UITabBarItem(title: "AR", image: nil, selectedImage: nil)
            let videoCallItem = UITabBarItem(title: "Call", image: nil, selectedImage: nil)
            let uberItem = UITabBarItem(title: "Uber", image: nil, selectedImage: nil)
            
            tabBar.items = [videoItem, arItem, videoCallItem, uberItem]
            tabBar.selectedItem = videoItem
            
            tabBar.delegate = self
            self.view.addSubview(cameraViewController.view)
            self.addChildViewController(cameraViewController)
            cameraViewController.view.snp.makeConstraints({ (make) in
                make.left.equalTo(self.view)
                make.right.equalTo(self.view)
                make.top.equalTo(self.view)
                make.bottom.equalTo(tabBar.snp.top)
            })
        }
    }
}

extension MainViewController:UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let index = tabBar.items?.index(of: item)
        print(index!)
    }
}
