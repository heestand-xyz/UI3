//
//  Content.swift
//  UI3
//
//  Created by Hexagons on 2019-09-27.
//

import SceneKit

public protocol UI3Object {
        
    var name: String { get }
    var width: CGFloat? { get }
    var height: CGFloat? { get }
    var length: CGFloat? { get }
    var paddingEdges: UI3Edges { get set }
    var paddingLength: CGFloat { get set }

    func node(frame: UI3Frame) -> SCNNode
    
    func frame(width: CGFloat?, height: CGFloat?, length: CGFloat?) -> UI3Object
    func padding(edges: UI3Edges, length: CGFloat) -> UI3Object
    func color(_ value: UIColor) -> UI3Object

}

public protocol UI3Content: UI3Object {
    
    init()
    
//    var size: UI3Size? { get }
    
    func shading(_ value: UI3Shading) -> UI3Content
    func isDoubleSided(_ value: Bool) -> UI3Content
    
}

public protocol UI3Control: UI3Content {
    
    func hover(over: Bool)
    func interact(at position: UI3Position)
    
}

public protocol UI3Model: UI3Content {
    
    var aspectWidth: CGFloat { get }
    var aspectHeight: CGFloat { get }
    var aspectLength: CGFloat { get }
    
}

public protocol UI3Modifier: UI3Object {
    
    var objects: [UI3Object] { get }
    
    func frames(in frame: UI3Frame) -> [UI3Frame]

}

public protocol UI3ModifierSingle: UI3Modifier {

    init(_ object: () -> (UI3Object))
    
}

public protocol UI3ModifierArray: UI3Modifier {
 
    init(@UI3Builder _ object: () -> (UI3Object))
    init(@UI3Builder _ objects: () -> ([UI3Object]))

}
