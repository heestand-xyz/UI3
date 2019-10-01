//
//  BoundingBox.swift
//  UI3
//
//  Created by Hexagons on 2019-09-27.
//

import SceneKit

public struct BoundingBox: UI3Content {
    
    public let name: String = "Bounding Box"
    public var width: CGFloat? = nil
    public var height: CGFloat? = nil
    public var length: CGFloat? = nil
    public var paddingEdges: UI3Edges = .none
    public var paddingLength: CGFloat = 0.0
    
    var color: UIColor = .white
    var shading: UI3Shading = .light
    var isDoubleSided: Bool = false
    
    // MARK: - Life Cycle
    
    public init() {
        if #available(iOS 10.0, *) {
            color = UIColor(displayP3Red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
        } else {
            color = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
        }
    }
    
    // MARK: - Node
    
    public func node(frame: UI3Frame) -> SCNNode {
        
        let node = SCNNode()
        
        for x in 0..<2 {
            let xf = CGFloat(x)
            for y in 0..<2 {
                let yf = CGFloat(y)
                for z in 0..<2 {
                    let zf = CGFloat(z)
                                        
                    let axis = Axis()
                        .color(color)
                    
                    let origin = UI3Position(x: frame.origin.x + xf * frame.size.x,
                                             y: frame.origin.y + yf * frame.size.y,
                                             z: frame.origin.z + zf * frame.size.z)
                    let size = UI3Scale(x: 0.1, y: 0.1, z: 0.1)
                    let frame = UI3Frame(origin: .zero, size: size)
                    
                    let axisNode = axis.node(frame: frame)
                    
                    let xyz = x + y + z
                    if xyz == 1 {
                        let r: CGFloat = -.pi / 2
                        axisNode.eulerAngles = SCNVector3(z == 1 ? r : 0.0,
                                                          x == 1 ? r : 0.0,
                                                          y == 1 ? r : 0.0)
                    } else if xyz == 2 {
                        let r: CGFloat = .pi
                        axisNode.eulerAngles = SCNVector3(x == 0 ? r : 0.0,
                                                          y == 0 ? r : 0.0,
                                                          z == 0 ? r : 0.0)
                    } else if xyz == 3 {
                        axisNode.eulerAngles = SCNVector3(-.pi / 2, 0.0, .pi)
                    }
                    axisNode.position = (origin).scnVector3
                    
                    node.addChildNode(axisNode)
                    
                }
            }
        }
        
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
