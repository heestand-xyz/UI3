//
//  Axis.swift
//  UI3
//
//  Created by Hexagons on 2019-09-27.
//

import SceneKit

public struct Axis: UI3Object {
    
    public let node: SCNNode
    
    public init(color: UIColor? = nil) {
        
        node = SCNNode()
        
        node.addChildNode(box(axis: .x, color: color ?? .red))
        node.addChildNode(box(axis: .y, color: color ?? .green))
        node.addChildNode(box(axis: .z, color: color ?? .blue))
        
    }
    
    func box(axis: UI3Axis, color: UIColor) -> SCNNode {
        
        let length: CGFloat = 0.1
        let width: CGFloat = 0.005
        let chamferRadius: CGFloat = 0.0025
        
        let box = Box(width: axis == .x ? length : width,
                      height: axis == .y ? length : width,
                      length: axis == .z ? length : width,
                      chamferRadius: chamferRadius,
                      color: color,
                      shading: .constant,
                      isDoubleSided: true)
        
        box.node.position = SCNVector3(axis == .x ? length / 2 : 0,
                                       axis == .y ? length / 2 : 0,
                                       axis == .z ? length / 2 : 0)
        
        return box.node
        
    }
    
}
