//
//  Axis.swift
//  UI3
//
//  Created by Hexagons on 2019-09-27.
//

import SceneKit

public struct Axis: UI3Content {
        
    public let name: String = "Axis"
    public var width: CGFloat? = nil
    public var height: CGFloat? = nil
    public var length: CGFloat? = nil
    public var paddingEdges: UI3Edges = .none
    public var paddingLength: CGFloat = 0.0
    
    public var size: UI3Size? { return nil }
    var color: UIColor = .white
    var shading: UI3Shading = .light
    var isDoubleSided: Bool = false
    
    var rgbColor: Bool = true
    
    // MARK: - Life Cycle
    
    public init() {}
    
    // MARK: - Axie
    
    func axie(frame: UI3Frame, axis: UI3Axis, color: UIColor) -> SCNNode {
        
        let sizeFraction: CGFloat = 0.1
        let cornerRadius: CGFloat = 0.0025
        
        let box = Box()
            .cornerRadius(cornerRadius)
            .color(color)
            .shading(.constant)
            .isDoubleSided(isDoubleSided)
        
        let origin = UI3Position(x: frame.origin.x + (axis == .x ? frame.size.x * sizeFraction * 2 : 0.0),
                                 y: frame.origin.y + (axis == .y ? frame.size.y * sizeFraction * 2 : 0.0),
                                 z: frame.origin.z + (axis == .z ? frame.size.z * sizeFraction * 2 : 0.0))
        
        let size = UI3Scale(x: frame.size.x * (axis == .x ? 1.0 - sizeFraction * 2 : sizeFraction),
                            y: frame.size.y * (axis == .y ? 1.0 - sizeFraction * 2 : sizeFraction),
                            z: frame.size.z * (axis == .z ? 1.0 - sizeFraction * 2 : sizeFraction))

        return box.node(frame: UI3Frame(origin: origin, size: size))
        
    }
    
    // MARK: - Node
    
    public func node(frame: UI3Frame) -> SCNNode {
        
        let node = SCNNode()
        
        node.addChildNode(axie(frame: frame, axis: .x, color: rgbColor ? .red : color))
        node.addChildNode(axie(frame: frame, axis: .y, color: rgbColor ? .green : color))
        node.addChildNode(axie(frame: frame, axis: .z, color: rgbColor ? .blue : color))
        
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
    
    public func padding(edges: UI3Edges, length: CGFloat) -> UI3Object {
        var object = self
        object.paddingEdges = edges
        object.paddingLength = length
        return object
    }
        
    // MARK: - Content
    
    public func color(_ value: UIColor) -> UI3Content {
        var content = self
        content.color = value
        content.rgbColor = false
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
