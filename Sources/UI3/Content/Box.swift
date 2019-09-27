//
//  Box.swift
//  UI3
//
//  Created by Hexagons on 2019-09-27.
//

import SceneKit

public struct Box: UI3Object {
    
    public let node: SCNNode
    
    public init(width: CGFloat = 1.0,
                height: CGFloat = 1.0,
                length: CGFloat = 1.0,
                chamferRadius: CGFloat = 0.0,
                color: UIColor = .white,
                shading: UI3Shading = .light,
                isDoubleSided: Bool = false) {
        
        let box = SCNBox(width: width,
                         height: height,
                         length: length,
                         chamferRadius: chamferRadius)
        box.firstMaterial!.lightingModel = shading.lightingModel
        box.firstMaterial!.diffuse.contents = color
        box.firstMaterial!.isDoubleSided = isDoubleSided
        
        node = SCNNode(geometry: box)
    }
    
}
