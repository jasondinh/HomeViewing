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
    var callViewController:CallViewController?
    var videoViewController:VideoViewController?
    var activeViewNum = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar = UITabBar(frame: .zero)
        self.cameraViewController = CameraViewController()
        self.callViewController = CallViewController()
        self.videoViewController = VideoViewController()
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
            
//            self.view.addSubview(callViewController.view)
//            self.addChildViewController(callViewController)
//            callViewController.view.snp.makeConstraints({ (make) in
//                make.left.equalTo(self.view)
//                make.right.equalTo(self.view)
//                make.top.equalTo(self.view)
//                make.bottom.equalTo(tabBar.snp.top)
//            })
            
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
    
    func removeViewController() {
        switch activeViewNum {
        case 0:
            return
        case 1:
            self.cameraViewController?.view.removeFromSuperview()
            self.cameraViewController?.removeFromParentViewController()
        case 2:
            self.callViewController?.view.removeFromSuperview()
            self.callViewController?.removeFromParentViewController()
        case 3:
            return
        default:
            return
        }
        
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let index = tabBar.items?.index(of: item)
        if index == activeViewNum {
            return
        }
        if index != 3 { // UBER
            removeViewController()
        }
        switch index! {
        case 0:
            self.view.addSubview(videoViewController!.view)
            self.addChildViewController(videoViewController!)
            videoViewController?.view.snp.makeConstraints({ (make) in
                make.left.equalTo(self.view)
                make.right.equalTo(self.view)
                make.top.equalTo(self.view)
                make.bottom.equalTo(tabBar.snp.top)
            })
            activeViewNum = 0
        case 1:
            self.view.addSubview(self.cameraViewController!.view)
            self.addChildViewController(self.cameraViewController!)
            self.cameraViewController?.view.snp.makeConstraints({ (make) in
                make.left.equalTo(self.view)
                make.right.equalTo(self.view)
                make.top.equalTo(self.view)
                make.bottom.equalTo(tabBar.snp.top)
            })
            activeViewNum = 1
        case 2:
            self.view.addSubview(callViewController!.view)
            self.addChildViewController(callViewController!)
            callViewController?.view.snp.makeConstraints({ (make) in
                make.left.equalTo(self.view)
                make.right.equalTo(self.view)
                make.top.equalTo(self.view)
                make.bottom.equalTo(tabBar.snp.top)
            })
            activeViewNum = 2
        case 3:
            let url = URL(string: "https://m.uber.com/ul/?action=setPickup&client_id=n8V9GfHfYf3rfRuWuU83ORc5ehAYwwmo&pickup[formatted_address]=163%20Tampines%20Street%2012%20Singapore&pickup[latitude]=1.349478&pickup[longitude]=103.947256")
            
            if UIApplication.shared.canOpenURL(URL(fileURLWithPath: "uber://")) {
                UIApplication.shared.open(url!)
            } else {
                return
            }
            activeViewNum = 3
        default:
            return
        }
    }
}
