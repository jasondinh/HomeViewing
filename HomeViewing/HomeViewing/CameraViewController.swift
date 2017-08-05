//
//  CameraViewController.swift
//  HomeViewing
//
//  Created by Jason on 5/8/17.
//  Copyright © 2017 TinyWhale. All rights reserved.
//

import UIKit
import ARKit

class CameraViewController: UIViewController {
    var sceneView:ARSCNView?
    var planes:[String:Any]?
    var arConfig:ARWorldTrackingSessionConfiguration?
    
    override func viewDidLoad() {
        self.setupScene()
        
        if let sceneView = self.sceneView {
            self.view.addSubview(sceneView)
            sceneView.snp.makeConstraints({ (make) in
                make.size.equalTo(self.view)
            })
        }
    }
    
    func setupScene() {
        self.sceneView = ARSCNView(frame: .zero)
        self.arConfig = ARWorldTrackingSessionConfiguration()
        
        if let sceneView = self.sceneView,
            let arConfig = self.arConfig {
            arConfig.isLightEstimationEnabled = true
            arConfig.planeDetection = .horizontal
            
            sceneView.delegate = self;
            sceneView.session.run(arConfig, options: [])
        }
        self.planes = [:]
        
    }
}

extension CameraViewController: ARSCNViewDelegate {
    
}
