//
//  Button.swift
//  UI3
//
//  Created by Anton Heestand on 2019-10-01.
//

import SceneKit
import SwiftUI

public struct Button: UI3Control {
   
    public let name: String = "Button"
    public var width: CGFloat? { object.width }
    public var height: CGFloat? { object.height }
    public var length: CGFloat? { object.length }
    public var paddingEdges: UI3Edges = .none
    public var paddingLength: CGFloat = 0.0
    
    var color: UIColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
    var shading: UI3Shading = .light
    var isDoubleSided: Bool = false
    
    var object: UI3Object
    
    let action: () -> ()

    // MARK: - Life Cycle
    
    public init() {
        action = {}
        object = Text("Button")
    }
      
    public init(action: @escaping () -> (), _ object: () -> (UI3Object)) {
        self.action = action
        self.object = object()
    }
    
    // MARK: - Node
    
    public func node(frame: UI3Frame) -> SCNNode {

        let object = self.object
            .color(color)
        
        let node = object.node(frame: frame)
        
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
        object.object = object.object.color(value)
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
    
    // MARK: - Control
    
    public func interact() {
        action()
    }
    
}
