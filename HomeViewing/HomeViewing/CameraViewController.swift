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
        
        self.setupPhysics()
        self.setupRecognizer()
    }
    
    func setupPhysics() {
        if let scene = self.sceneView?.scene {
            scene.physicsWorld.contactDelegate = self
        }
    }
    
    func setupRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(gesture:)))
        self.sceneView?.addGestureRecognizer(tap)
    }
    
    func tapped(gesture:UITapGestureRecognizer) {
        //find the nearest plane
        
        let tapPoint = gesture.location(in: self.sceneView!)
        let arHitResult = self.sceneView?.hitTest(tapPoint, types: .existingPlaneUsingExtent)
        if arHitResult!.count == 0 {
            return
        }
        self.insertCube(hitResult: arHitResult!.first!)
    }
    
    func insertCube(hitResult: ARHitTestResult) {
        let insertionYOffset:Float = 0.01
        let position = SCNVector3(hitResult.worldTransform.columns.3.x,
                                  hitResult.worldTransform.columns.3.y + insertionYOffset,
                                  hitResult.worldTransform.columns.3.z);
        
        let model = Model(modelName: "wolf", position: position)
        self.sceneView?.scene.rootNode.addChildNode(model)
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

extension CameraViewController: SCNPhysicsContactDelegate {
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        print("begin contact")
    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didUpdate contact: SCNPhysicsContact) {
        print("update contact")
    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didEnd contact: SCNPhysicsContact) {
        print("end contact")
    }
}
