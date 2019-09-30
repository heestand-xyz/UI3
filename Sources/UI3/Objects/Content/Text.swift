//
//  Text.swift
//  UI3
//
//  Created by Anton Heestand on 2019-09-30.
//

import SceneKit

public struct Text: UI3Content {
    
    public let name: String = "Text"
    public var width: CGFloat? { CGFloat(textNode.boundingBox.max.x - textNode.boundingBox.min.x) * textScale }
    public var height: CGFloat? { CGFloat(textNode.boundingBox.max.y - textNode.boundingBox.min.y) * textScale }
    public var length: CGFloat? { CGFloat(textNode.boundingBox.max.z - textNode.boundingBox.min.z) }
    public var paddingEdges: UI3Edges = .none
    public var paddingLength: CGFloat = 0.0
    
    var color: UIColor = .black
    var shading: UI3Shading = .light
    var isDoubleSided: Bool = false
    
    let textScale: CGFloat = 0.01
    let text: SCNText
    let textNode: SCNNode

    // MARK: - Life Cycle
    
    public init() {
        text = SCNText()
        textNode = SCNNode()
    }
      
    public init(_ text: String, extrusionDepth: CGFloat = 0.01) {
        self.text = SCNText(string: text, extrusionDepth: extrusionDepth)
        self.textNode = SCNNode(geometry: self.text)
        self.textNode.scale = SCNVector3(textScale, textScale, 1.0)
    }
    
    // MARK: - Node
    
    public func node(frame: UI3Frame) -> SCNNode {
        print("text:", frame)
        text.firstMaterial!.lightingModel = shading.lightingModel
        text.firstMaterial!.diffuse.contents = color
        text.firstMaterial!.isDoubleSided = isDoubleSided || UI3Defaults.wireframe
        if #available(iOS 11.0, *) {
            text.firstMaterial!.fillMode = UI3Defaults.wireframe ? .lines : .fill
        }
        
        let size = UI3Size(x: width!, y: height!, z: length!)
        let offset = UI3Position(x: CGFloat(textNode.boundingBox.min.x) * textScale,
                                 y: CGFloat(textNode.boundingBox.min.y) * textScale,
                                 z: CGFloat(textNode.boundingBox.min.z))
        
        let node = SCNNode()
        node.addChildNode(textNode)
        node.position = (frame.position - size / 2 - offset).scnVector3
        
        return node
        
    }
    
    // MARK: - Object
    
    public func frame(width: CGFloat? = nil, height: CGFloat? = nil, length: CGFloat? = nil) -> UI3Object {
        return self
    }
    
    public func padding(edges: UI3Edges, length: CGFloat) -> UI3Object {
        var object = self
        object.paddingEdges = edges
        object.paddingLength = length
        return object
    }
    
    // MARK: - Content
    
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