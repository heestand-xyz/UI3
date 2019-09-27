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
        
        for x in 0..<2 {
            let xWay = CGFloat(x * 2) - 1.0
            for y in 0..<2 {
                let yWay = CGFloat(y * 2) - 1.0
                for z in 0..<2 {
                    let zWay = CGFloat(z * 2) - 1.0
                    
                    let axis = Axis(color: color)
                    axis.node.position = SCNVector3(xWay / 2, yWay / 2, zWay / 2)
                    axis.node.scale = SCNVector3(-xWay, -yWay, -zWay)
                    node.addChildNode(axis.node)
                    
                }
            }
        }
        
    }
    
}
