//
//  Model.swift
//  HomeViewing
//
//  Created by Jason on 5/8/17.
//  Copyright © 2017 TinyWhale. All rights reserved.
//

import UIKit
import ARKit

class Model:SCNNode {
    convenience init(modelName:String, position:SCNVector3) {
        self.init()
        
        let baseRatio:Float = 0.001
        
        //sofa
        var scene = SCNScene(named: "intertime_1191_liv_2_seater_sofa_wide_nofh.dae")
        
        var nodeArray = scene?.rootNode.childNodes
        
        var offsetX:Float, offsetY:Float, offsetZ:Float
        
        offsetX = 0
        offsetY = 0
        offsetZ = 0
        
        for childNode in nodeArray! {
            childNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
            childNode.physicsBody?.mass = 0.0
            childNode.categoryBitMask = 2
            childNode.position = SCNVector3Make(position.x + offsetX, position.y + offsetY, position.z + offsetZ)
            
            let scale:Float = baseRatio * 5
            childNode.scale = SCNVector3(x: scale, y: scale, z: scale)
            childNode.eulerAngles = SCNVector3Make(-Float.pi/2, -Float.pi/2, 0)
            
            self.addChildNode(childNode as SCNNode)
        }
        
        //table
        scene = SCNScene(named: "Beek_Collection_Bibi_120x120_mat(1).dae")
        
        nodeArray = scene?.rootNode.childNodes
        
        offsetX = -0.25
        offsetY = 0
        offsetZ = 0
        
        for childNode in nodeArray! {
            childNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
            childNode.physicsBody?.mass = 0.0
            childNode.categoryBitMask = 2
            childNode.position = SCNVector3Make(position.x + offsetX, position.y + offsetY, position.z + offsetZ)
            
            let scale:Float = baseRatio * 6
            childNode.scale = SCNVector3(x: scale, y: scale, z: scale)
            childNode.eulerAngles = SCNVector3Make(-Float.pi/2, -Float.pi/2, 0)
            
            self.addChildNode(childNode as SCNNode)
        }
        
        //tv
        scene = SCNScene(named: "WINNER.dae")
        
        nodeArray = scene?.rootNode.childNodes
        
        offsetX = -0.6
        offsetY = 0
        offsetZ = 0
        
        for childNode in nodeArray! {
            childNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
            childNode.physicsBody?.mass = 0.0
            childNode.categoryBitMask = 2
            childNode.position = SCNVector3Make(position.x + offsetX, position.y + offsetY, position.z + offsetZ)
            
            let scale:Float = baseRatio * 2
            childNode.scale = SCNVector3(x: scale, y: scale, z: scale)
            childNode.eulerAngles = SCNVector3Make(-Float.pi/2, Float.pi/2, 0)
            
            self.addChildNode(childNode as SCNNode)
        }
        
        //lamp
        scene = SCNScene(named: "lumina_italia_matrix_terra.dae")
        
        nodeArray = scene?.rootNode.childNodes
        
        offsetX = 0
        offsetY = 0
        offsetZ = 0.3
        
        for childNode in nodeArray! {
            childNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
            childNode.physicsBody?.mass = 0.0
            childNode.categoryBitMask = 2
            childNode.position = SCNVector3Make(position.x + offsetX, position.y + offsetY, position.z + offsetZ)
            
            let scale:Float = baseRatio * 1.3
            childNode.scale = SCNVector3(x: scale, y: scale, z: scale)
            childNode.eulerAngles = SCNVector3Make(-Float.pi/2, -Float.pi, 0)
            
            self.addChildNode(childNode as SCNNode)
        }
    }
}

