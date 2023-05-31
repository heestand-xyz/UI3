//
//  Sphere.swift
//  UI3
//
//  Created by Anton Heestand on 2019-09-30.
//

import SceneKit

public struct Sphere: UI3Content {
    
    public let name: String = "Sphere"
    
    public var width: CGFloat? = nil
    public var height: CGFloat? = nil
    public var length: CGFloat? = nil
    
    public var paddingEdges: UI3Edges = .none
    public var paddingLength: CGFloat = 0.0
    
    var color: _Color = .white
    var shading: UI3Shading = .light
    var isDoubleSided: Bool = false
    
    var isGeodesic: Bool = false
    
    // MARK: - Life Cycle
    
    public init() {}
    
    // MARK: - Node
    
    public func node(frame: UI3Frame) -> SCNNode {

        let sphere = SCNSphere(radius: min(frame.size.x, frame.size.y, frame.size.z) / 2)
        sphere.isGeodesic = isGeodesic
        sphere.firstMaterial!.lightingModel = shading.lightingModel
        sphere.firstMaterial!.diffuse.contents = color
        sphere.firstMaterial!.isDoubleSided = isDoubleSided || UI3Defaults.wireframe
        sphere.firstMaterial!.fillMode = UI3Defaults.wireframe ? .lines : .fill
        
        let node = SCNNode(geometry: sphere)
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
    
    // MARK: - Sphere
    
    public func isGeodesic(_ value: Bool) -> Sphere {
        var sphere = self
        sphere.isGeodesic = value
        return sphere
    }
    
}
