//
//  Axis.swift
//  UI3
//
//  Created by Hexagons on 2019-09-27.
//

import SceneKit

public struct Axis: UI3Content {
        
    public var width: CGFloat? = nil
    public var height: CGFloat? = nil
    public var length: CGFloat? = nil
    public var paddingEdges: UI3Edges = .all
    public var paddingLength: CGFloat? = nil
    
    var color: UIColor = .white
    var shading: UI3Shading = .light
    var isDoubleSided: Bool = false
    
    // MARK: - Life Cycle
    
    public init() {}
    
    // MARK: - Axie
    
    func axie(axis: UI3Axis, color: UIColor) -> SCNNode {
        
        let length: CGFloat = 0.1
        let width: CGFloat = 0.005
        let cornerRadius: CGFloat = 0.0025
        
//        let box = Box()
//        let box = Box(width: axis == .x ? length : width,
//                      height: axis == .y ? length : width,
//                      length: axis == .z ? length : width,
//                      cornerRadius: cornerRadius,
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
    
    // MARK: - Object
    
    public func frame(width: CGFloat? = nil, height: CGFloat? = nil, length: CGFloat? = nil) -> UI3Object {
        var object = self
        if width != nil { object.width = width }
        if height != nil { object.height = height }
        if length != nil { object.length = length }
        return object
    }
    
    public func padding(edges: UI3Edges = .all, length: CGFloat = UI3Defaults.paddingLength) -> UI3Object {
        var object = self
        object.paddingEdges = edges
        object.paddingLength = length
        return object
    }
        
    // MARK: - Content
    
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
