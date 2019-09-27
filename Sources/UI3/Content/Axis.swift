//
//  Axis.swift
//  UI3
//
//  Created by Hexagons on 2019-09-27.
//

import SceneKit

public struct Axis: UI3Content {
        
    // MARK: Global Properies
    var color: UIColor = .white
    var shading: UI3Shading = .light
    var isDoubleSided: Bool = false
    
    // MARK: - Life Cycle
    
    public init() {}
    
    // MARK: - Axie
    
    func axie(axis: UI3Axis, color: UIColor) -> SCNNode {
        
        let length: CGFloat = 0.1
        let width: CGFloat = 0.005
        let chamferRadius: CGFloat = 0.0025
        
//        let box = Box()
//        let box = Box(width: axis == .x ? length : width,
//                      height: axis == .y ? length : width,
//                      length: axis == .z ? length : width,
//                      chamferRadius: chamferRadius,
//                      color: color,
//                      shading: .constant,
//                      isDoubleSided: true)
        
//        box.node.position = SCNVector3(axis == .x ? length / 2 : 0,
//                                       axis == .y ? length / 2 : 0,
//                                       axis == .z ? length / 2 : 0)
//
//        return box.node
       
        return SCNNode()
        
    }
    
    // MARK: - Node
    
    public func node(frame: UI3Frame) -> SCNNode {
        
        let node = SCNNode()
        
        node.addChildNode(axie(axis: .x, color: color ?? .red))
        node.addChildNode(axie(axis: .y, color: color ?? .green))
        node.addChildNode(axie(axis: .z, color: color ?? .blue))
        
        return node
        
    }
    
    // MARK: - Frame
    
    public func frame(_ frame: UI3Frame) -> UI3Object {
        return self
    }
    
    // MARK: - Mutating Funcs
    
    // MARK: Global Mutating Funcs
    
    public func color(_ value: UIColor) -> UI3Content {
        var content = self
        content.color = value
        return content
    }
    
    public func shading(_ value: UI3Shading) -> UI3Content {
        var content = self
        content.shading = value
        return content
    }
    
    public func isDoubleSided(_ value: Bool) -> UI3Content {
        var content = self
        content.isDoubleSided = value
        return content
    }
    
}
