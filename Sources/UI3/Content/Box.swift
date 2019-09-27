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
        
        return SCNNode(geometry: box)
        
    }
    
    // MARK: - Mutating Funcs
    
    public mutating func chamferRadius(_ value: CGFloat) -> Box {
        chamferRadius = value
        return self
    }
    
    // MARK: Global Mutating Funcs
    
    public mutating func color(_ value: UIColor) -> UI3Content {
        color = value
        return self
    }
    
    public mutating func shading(_ value: UI3Shading) -> UI3Content {
        shading = value
        return self
    }
    
    public mutating func isDoubleSided(_ value: Bool) -> UI3Content {
        isDoubleSided = value
        return self
    }
    
}
