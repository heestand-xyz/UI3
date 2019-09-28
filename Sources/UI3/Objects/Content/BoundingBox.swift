//
//  BoundingBox.swift
//  UI3
//
//  Created by Hexagons on 2019-09-27.
//

import SceneKit

public struct BoundingBox: UI3Content {
    
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
    
    // MARK: - Node
    
    public func node(frame: UI3Frame) -> SCNNode {
        
        let node = SCNNode()
        
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
                    
//                    let axis = Axis(color: color)
//                    axis.node.position = SCNVector3(xWay / 2, yWay / 2, zWay / 2)
//                    axis.node.scale = SCNVector3(-xWay, -yWay, -zWay)
//                    node.addChildNode(axis.node)
                    
                }
            }
        }
        
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
