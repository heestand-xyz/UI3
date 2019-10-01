//
//  Model.swift
//  UI3
//
//  Created by Hexagons on 2019-09-30.
//

import SceneKit

public struct Model: UI3Model {
    
    public let name: String = "Model"
    public var width: CGFloat? = nil
    public var height: CGFloat? = nil
    public var length: CGFloat? = nil
    public var aspectWidth: CGFloat { CGFloat(node.boundingBox.max.x - node.boundingBox.min.x) }
    public var aspectHeight: CGFloat { CGFloat(node.boundingBox.max.y - node.boundingBox.min.y) }
    public var aspectLength: CGFloat { CGFloat(node.boundingBox.max.z - node.boundingBox.min.z) }
    public var paddingEdges: UI3Edges = .none
    public var paddingLength: CGFloat = 0.0
    
    var color: UIColor? = nil
    var shading: UI3Shading? = nil
    var isDoubleSided: Bool? = nil
        
    let node: SCNNode
    
    // MARK: - Life Cycle
    
    public init() {
        node = SCNNode()
    }
    
    public init(_ path: String) {
        node = SCNNode()
        guard let scene = SCNScene(named: path) else {
            print("UI3 - Model - Asset not found.")
            return
        }
        node.addChildNode(scene.rootNode)
    }
    
    // MARK: - Node
    
    public func node(frame: UI3Frame) -> SCNNode {

        func set(_ node: SCNNode) {
            if let geo = node.geometry {
                for material in geo.materials {
                    if let val = shading?.lightingModel {
                        material.lightingModel = val
                    }
                    if let val = color {
                        material.diffuse.contents = val
                    }
                    if let val = isDoubleSided {
                        material.isDoubleSided = val
                    }
                    if #available(iOS 11.0, *) {
                        material.fillMode = UI3Defaults.wireframe ? .lines : .fill
                    }
                }
            }
            for childNode in node.childNodes {
                set(childNode)
            }
        }
        set(node)
        
        let size = UI3Size(x: CGFloat(node.boundingBox.max.x - node.boundingBox.min.x),
                           y: CGFloat(node.boundingBox.max.y - node.boundingBox.min.y),
                           z: CGFloat(node.boundingBox.max.z - node.boundingBox.min.z))
        let relSize = frame.size / size
        let scale = min(relSize.x, relSize.y, relSize.z)
        
        node.scale = UI3Scale(x: scale, y: scale, z: scale).scnVector3
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
    
}
