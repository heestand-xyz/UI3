//
//  Box.swift
//  UI3
//
//  Created by Hexagons on 2019-09-27.
//

import SceneKit

public struct Box: UI3Content {
    
    public let name: String = "Box"
    
    public var width: CGFloat? = nil
    public var height: CGFloat? = nil
    public var length: CGFloat? = nil
    
    public var paddingEdges: UI3Edges = .none
    public var paddingLength: CGFloat = 0.0
    
    var color: UIColor = .white
    var shading: UI3Shading = .light
    var isDoubleSided: Bool = false
    
    var cornerRadius: CGFloat = 0.0
    
    // MARK: - Life Cycle
    
    public init() {}
    
    // MARK: - Node
    
    public func node(frame: UI3Frame) -> SCNNode {

        let box = SCNBox(width: frame.size.x,
                         height: frame.size.y,
                         length: frame.size.z,
                         chamferRadius: cornerRadius)
        box.firstMaterial!.lightingModel = shading.lightingModel
        box.firstMaterial!.diffuse.contents = color
        box.firstMaterial!.isDoubleSided = isDoubleSided || UI3Defaults.wireframe
        box.firstMaterial!.fillMode = UI3Defaults.wireframe ? .lines : .fill
        
        let node = SCNNode(geometry: box)
        node.position = frame.position.scnVector3
        
        return node
        
    }
    
    // MARK: - Object
    
    public func frame(width: CGFloat?, height: CGFloat?, length: CGFloat?) -> UI3Object {
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
    
    public func color(_ value: UIColor) -> UI3Object {
        var object = self
        object.color = value
        return object
    }
    
    // MARK: - Content
    
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
    
    // MARK: - Box
    
    public func cornerRadius(_ value: CGFloat) -> Box {
        var box = self
        box.cornerRadius = value
        return box
    }
    
}
