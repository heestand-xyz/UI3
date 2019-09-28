//
//  Box.swift
//  UI3
//
//  Created by Hexagons on 2019-09-27.
//

import SceneKit

public struct Box: UI3Content {
    
    public var width: CGFloat? = nil
    public var height: CGFloat? = nil
    public var length: CGFloat? = nil
    
    var color: UIColor = .white
    var shading: UI3Shading = .light
    var isDoubleSided: Bool = false
    
    var chamferRadius: CGFloat = 0.0
    
    // MARK: - Life Cycle
    
    public init() {}
    
    // MARK: - Node
    
    public func node(frame: UI3Frame) -> SCNNode {
        
        let box = SCNBox(width: frame.size.x,
                         height: frame.size.y,
                         length: frame.size.z,
                         chamferRadius: chamferRadius)
        box.firstMaterial!.lightingModel = shading.lightingModel
        box.firstMaterial!.diffuse.contents = color
        box.firstMaterial!.isDoubleSided = isDoubleSided || UI3Defaults.wireframe
        if #available(iOS 11.0, *) {
            box.firstMaterial!.fillMode = UI3Defaults.wireframe ? .lines : .fill
        }
        
        let node = SCNNode(geometry: box)
        node.position = frame.position.scnVector3
        
        return node
        
    }
    
    // MARK: - Frame
    
    public func frame(width: CGFloat? = nil, height: CGFloat? = nil, length: CGFloat? = nil) -> UI3Object {
        var object = self
        if width != nil { object.width = width }
        if height != nil { object.height = height }
        if length != nil { object.length = length }
        return object
    }
    
    // MARK: - Box
    
    public func chamferRadius(_ value: CGFloat) -> Box {
        var box = self
        box.chamferRadius = value
        return box
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
