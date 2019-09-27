//
//  BoundingBox.swift
//  UI3
//
//  Created by Hexagons on 2019-09-27.
//

import SceneKit

public struct BoundingBox: UI3Object {
    
    public let node: SCNNode
    
    public init() {
        
        node = SCNNode()
        
        let color: UIColor
        if #available(iOS 10.0, *) {
            color = UIColor(displayP3Red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
        } else {
            color = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
        }
        let length: CGFloat = 0.1
        let width: CGFloat = 0.005
        let chamfer: CGFloat = 0.0025
        
        func box(axis: UI3Axis) -> SCNNode {
            let box = SCNBox(width: axis == .x ? length : width,
                             height: axis == .y ? length : width,
                             length: axis == .z ? length : width,
                             chamferRadius: chamfer)
            box.firstMaterial!.lightingModel = .constant
            box.firstMaterial!.diffuse.contents = color
            box.firstMaterial!.isDoubleSided = true
            let node = SCNNode(geometry: box)
            node.position = SCNVector3(axis == .x ? length / 2 : 0,
                                       axis == .y ? length / 2 : 0,
                                       axis == .z ? length / 2 : 0)
            return node
        }
        
        for x in 0..<2 {
            let xWay = CGFloat(x * 2) - 1.0
            for y in 0..<2 {
                let yWay = CGFloat(y * 2) - 1.0
                for z in 0..<2 {
                    let zWay = CGFloat(z * 2) - 1.0
                    
                    let boundNode = SCNNode()
                    boundNode.position = SCNVector3(xWay / 2, yWay / 2, zWay / 2)
                    boundNode.scale = SCNVector3(-xWay, -yWay, -zWay)
                    
                    boundNode.addChildNode(box(axis: .x))
                    boundNode.addChildNode(box(axis: .y))
                    boundNode.addChildNode(box(axis: .z))
                    
                    node.addChildNode(boundNode)
                    
                }
            }
        }
        
    }
    
}
