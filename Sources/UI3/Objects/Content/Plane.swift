//
//  Plane.swift
//  UI3
//
//  Created by Anton Heestand on 2019-10-01.
//

import SceneKit

public struct Plane: UI3Content {
    
    public let name: String = "Plane"
    
    public var width: CGFloat? { return overPlane.axes.0 != .x && overPlane.axes.1 != .x ? 0.001 : nil }
    public var height: CGFloat? { return overPlane.axes.0 != .y && overPlane.axes.1 != .y ? 0.001 : nil }
    public var length: CGFloat? { return overPlane.axes.0 != .z && overPlane.axes.1 != .z ? 0.001 : nil }
    
    public var paddingEdges: UI3Edges = .none
    public var paddingLength: CGFloat = 0.0
    
    var color: UIColor = .white
    var shading: UI3Shading = .light
    var isDoubleSided: Bool = true
    
    var cornerRadius: CGFloat = 0.0
    
    let overPlane: UI3Plane
    
    // MARK: - Life Cycle
    
    public init(plane: UI3Plane = .xy) {
        overPlane = plane
    }
    
    // MARK: - Node
    
    public func node(frame: UI3Frame) -> SCNNode {

        let plane = SCNPlane(width: frame.size.value(on: overPlane.axes.0),
                             height: frame.size.value(on: overPlane.axes.1))
        plane.cornerRadius = cornerRadius
        plane.firstMaterial!.lightingModel = shading.lightingModel
        plane.firstMaterial!.diffuse.contents = color
        plane.firstMaterial!.isDoubleSided = isDoubleSided || UI3Defaults.wireframe
        plane.firstMaterial!.fillMode = UI3Defaults.wireframe ? .lines : .fill
        
        let node = SCNNode(geometry: plane)
        
        switch overPlane {
        case .xy:
            break
        case .yz:
            node.eulerAngles.x = .pi / 2
            node.eulerAngles.z = .pi / 2
            break
        case .xz:
            node.eulerAngles.x = .pi / 2
        }
        
        node.position = frame.position.scnVector3
        
        return node
        
    }
    
    // MARK: - Object
    
    public func frame(width: CGFloat?, height: CGFloat?, length: CGFloat?) -> UI3Object {
        return self
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
    
    // MARK: - Plane
    
    public func cornerRadius(_ value: CGFloat) -> Plane {
        var plane = self
        plane.cornerRadius = value
        return plane
    }
    
}
