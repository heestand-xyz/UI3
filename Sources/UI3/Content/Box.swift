//
//  Box.swift
//  UI3
//
//  Created by Hexagons on 2019-09-27.
//

import SceneKit

public struct Box: UI3Content {
    
    var chamferRadius: CGFloat = 0.0
    
    // MARK: Global Properies
    var color: UIColor = .white
    var shading: UI3Shading = .light
    var isDoubleSided: Bool = false
    
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
    
    public func frame(_ frame: UI3Frame) -> UI3Object {
        return self
    }
    
    // MARK: - Mutating Funcs
    
    public func chamferRadius(_ value: CGFloat) -> Box {
        var box = self
        box.chamferRadius = value
        return box
    }
    
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
