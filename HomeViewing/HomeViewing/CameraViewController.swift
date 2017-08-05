//
//  CameraViewController.swift
//  HomeViewing
//
//  Created by Jason on 5/8/17.
//  Copyright © 2017 TinyWhale. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class CameraViewController: UIViewController, ARSCNViewDelegate {
    var sceneView:ARSCNView?
    var planes:[String:Plane]?
    var arConfig:ARWorldTrackingSessionConfiguration?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = true
        
        self.setupScene()
        
        if let sceneView = self.sceneView {
            self.view.addSubview(sceneView)
            sceneView.snp.makeConstraints({ (make) in
                make.size.equalTo(self.view)
            })
        }
    }
    
    func setupScene() {
        self.sceneView = ARSCNView.init()
        self.arConfig = ARWorldTrackingSessionConfiguration()
        
        if let sceneView = self.sceneView,
            let arConfig = self.arConfig {
            
            let scene = SCNScene()
            
            sceneView.scene = scene
            sceneView.antialiasingMode = .multisampling4X
            
            arConfig.isLightEstimationEnabled = true
            arConfig.planeDetection = .horizontal
            
            sceneView.autoenablesDefaultLighting = true;
            sceneView.automaticallyUpdatesLighting = true;
            sceneView.showsStatistics = true
            sceneView.debugOptions = [
                ARSCNDebugOptions.showWorldOrigin,
                ARSCNDebugOptions.showFeaturePoints
            ]
            sceneView.delegate = self;
            
            sceneView.session.run(arConfig);
            
        }
        self.planes = [:]
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        let plane = Plane(anchor: anchor as! ARPlaneAnchor, isHidden: false, with: Plane.currentMaterial())
        self.planes![anchor.identifier.uuidString] = plane
        node.addChildNode(plane!)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if let plane = self.planes![anchor.identifier.uuidString] {
            plane.update(anchor as! ARPlaneAnchor)
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        self.planes![anchor.identifier.uuidString] = nil
    }
}
