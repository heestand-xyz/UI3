//
//  Box.swift
//  UI3
//
//  Created by Hexagons on 2019-09-27.
//

import SceneKit

public struct Box: UI3Object {
    
    public let node: SCNNode
    
    public init() {
        node = SCNNode(geometry: SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.1))
    }
    
}
