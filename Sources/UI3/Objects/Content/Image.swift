//
//  Image.swift
//  UI3
//
//  Created by Anton Heestand on 2019-10-01.
//

import SceneKit

public struct Image: UI3Model {
    
    public let name: String = "Image"
    
    public var width: CGFloat? = nil
    public var height: CGFloat? = nil
    public var length: CGFloat? = nil
    public var aspectWidth: CGFloat { return image?.size.width ?? 1.0 }
    public var aspectHeight: CGFloat { return image?.size.height ?? 1.0 }
    public var aspectLength: CGFloat { return 1.0 }
    
    public var paddingEdges: UI3Edges = .none
    public var paddingLength: CGFloat = 0.0
    
    var color: _Color = .white
    var shading: UI3Shading = .light
    var isDoubleSided: Bool = false
    
    let image: _Image?
    let plane: UI3Plane
    
    // MARK: - Life Cycle
    
    public init(_ name: String, plane: UI3Plane = .xy) {
        image = _Image(named: name)
        self.plane = plane
    }
    
    // MARK: - Node
    
    public func node(frame: UI3Frame) -> SCNNode {
        
        let node = Plane(plane: plane)
            .shading(.constant)
            .node(frame: frame)
        
        node.geometry!.firstMaterial!.diffuse.contents = image
        
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
    
    public func color(_ value: _Color) -> UI3Object {
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
    
}
