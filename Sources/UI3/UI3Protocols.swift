//
//  Content.swift
//  UI3
//
//  Created by Hexagons on 2019-09-27.
//

import SceneKit

public protocol UI3Object {
    
    func node(frame: UI3Frame) -> SCNNode
    
//    mutating func frame(_ frame: UI3Frame) -> UI3Object
    
}

public protocol UI3Content: UI3Object {
    
    init()
    
    mutating func color(_ value: UIColor) -> UI3Content
    mutating func shading(_ value: UI3Shading) -> UI3Content
    mutating func isDoubleSided(_ value: Bool) -> UI3Content
    
}

public protocol UI3Modifier: UI3Object {
    
    var objects: [UI3Object] { get }
    
}

public protocol UI3ModifierSingle: UI3Modifier {

    init(_ object: () -> (UI3Object))
    
}

public protocol UI3ModifierArray: UI3Modifier {
 
    init(@UI3Builder _ objects: () -> ([UI3Object]))
    
}
