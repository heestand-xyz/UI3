//
//  Stack.swift
//  UI3
//
//  Created by Hexagons on 2019-09-27.
//

import SceneKit

public struct HStack: UI3ModifierArray {
    public var objects: [UI3Object]
    public var width: CGFloat? = nil
    public var height: CGFloat? = nil
    public var length: CGFloat? = nil
    public var paddingEdges: UI3Edges = .none
    public var paddingLength: CGFloat? = nil
    public init(@UI3Builder _ objects: () -> ([UI3Object])) {
        self.objects = objects()
    }
    public func node(frame: UI3Frame) -> SCNNode {
        Stack(axis: .x, { objects }).node(frame: frame)
    }
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
}

public struct VStack: UI3ModifierArray {
    public var objects: [UI3Object]
    public var width: CGFloat? = nil
    public var height: CGFloat? = nil
    public var length: CGFloat? = nil
    public var paddingEdges: UI3Edges = .none
    public var paddingLength: CGFloat? = nil
    public init(@UI3Builder _ objects: () -> ([UI3Object])) {
        self.objects = objects()
    }
    public func node(frame: UI3Frame) -> SCNNode {
        Stack(axis: .y, { objects }).node(frame: frame)
    }
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
}

public struct ZStack: UI3ModifierArray {
    public var objects: [UI3Object]
    public var width: CGFloat? = nil
    public var height: CGFloat? = nil
    public var length: CGFloat? = nil
    public var paddingEdges: UI3Edges = .none
    public var paddingLength: CGFloat? = nil
    public init(@UI3Builder _ objects: () -> ([UI3Object])) {
        self.objects = objects()
    }
    public func node(frame: UI3Frame) -> SCNNode {
        Stack(axis: .z, { objects }).node(frame: frame)
    }
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
}

public struct WStack: UI3ModifierArray {
    public var objects: [UI3Object]
    public var width: CGFloat? = nil
    public var height: CGFloat? = nil
    public var length: CGFloat? = nil
    public var paddingEdges: UI3Edges = .none
    public var paddingLength: CGFloat? = nil
    public init(@UI3Builder _ objects: () -> ([UI3Object])) {
        self.objects = objects()
    }
    public func node(frame: UI3Frame) -> SCNNode {
        Stack(axis: nil, { objects }).node(frame: frame)
    }
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
}

struct Stack: UI3ModifierArray {
    
    var axis: UI3Axis? = nil
    var objects: [UI3Object]
    
    public var width: CGFloat? = nil
    public var height: CGFloat? = nil
    public var length: CGFloat? = nil
    public var paddingEdges: UI3Edges = .none
    public var paddingLength: CGFloat? = nil
    
    // MARK: - Life Cycle
    
    init(@UI3Builder _ objects: () -> ([UI3Object])) {
        self.objects = objects()
    }
    
    init(axis: UI3Axis?, @UI3Builder _ objects: () -> ([UI3Object])) {
        self.axis = axis
        self.objects = objects()
    }
    
    // MARK: - Node
    
    func node(frame: UI3Frame) -> SCNNode {
        
        let node = SCNNode()
        
        var segments: [CGFloat?] = []
        if let axis = self.axis {
            for object in objects {
                let rawSize: CGFloat? = {
                    switch axis {
                    case .x: return object.width
                    case .y: return object.height
                    case .z: return object.length
                    }
                }()
                var size = rawSize
                if size != nil {
                    let paddingOnAxis = object.paddingEdges.on(axis: axis)
                    let paddingForAxis = paddingOnAxis ? (object.paddingLength ?? 0.0) : 0.0
                    let negativePadding = object.paddingEdges.negative ? paddingForAxis : 0.0
                    let positivePadding = object.paddingEdges.positive ? paddingForAxis : 0.0
                    let padding = negativePadding + positivePadding
                    size! += padding
                }
                segments.append(size)
            }
        }
        let totalSegments: CGFloat = segments.compactMap({$0}).reduce(0, { $0 + $1 })
        
        let leftoverTotalFraction: CGFloat = max(1.0 - totalSegments, 0.0)
        let leftoverCount: Int = segments.filter({ $0 == nil }).count
        let lefoverFraction: CGFloat? = leftoverCount > 0 ? leftoverTotalFraction / CGFloat(leftoverCount) : nil
        
        var position: CGFloat = 0.0
        print("-------")
        for object in objects {
            
            var subFrame: UI3Frame = .one
            
            if let axis = self.axis {
                
                let rawSize: CGFloat? = {
                    switch axis {
                    case .x: return object.width
                    case .y: return object.height
                    case .z: return object.length
                    }
                }()
                var size: CGFloat = rawSize ?? lefoverFraction!
                
                let padding = object.paddingLength ?? 0.0
                let paddingOnAxis = object.paddingEdges.on(axis: axis)
                let paddingForAxis = paddingOnAxis ? padding : 0.0
                let negativePadding = object.paddingEdges.negative ? paddingForAxis : 0.0
                let positivePadding = object.paddingEdges.positive ? paddingForAxis : 0.0
                let innerPadding = rawSize == nil ? negativePadding + positivePadding : 0.0
                
                let xLeftPadding = axis != .x ? (object.paddingEdges.left ? padding : 0.0) : 0.0
                let xRightPadding = axis != .x ? (object.paddingEdges.right ? padding : 0.0) : 0.0
                let xPadding = xLeftPadding + xRightPadding
                let yBottomPadding = axis != .y ? (object.paddingEdges.bottom ? padding : 0.0) : 0.0
                let yTopPadding = axis != .y ? (object.paddingEdges.top ? padding : 0.0) : 0.0
                let yPadding = yBottomPadding + yTopPadding
                let zFarPadding = axis != .z ? (object.paddingEdges.far ? padding : 0.0) : 0.0
                let zNearPadding = axis != .z ? (object.paddingEdges.near ? padding : 0.0) : 0.0
                let zPadding = zFarPadding + zNearPadding
                
                position += negativePadding
                size -= innerPadding
                
                subFrame = UI3Frame(origin: UI3Position(x: axis == .x ? position : xLeftPadding,
                                                        y: axis == .y ? position : yBottomPadding,
                                                        z: axis == .z ? position : zFarPadding),
                                    size: UI3Scale(x: axis == .x ? size : 1.0 - xPadding,
                                                   y: axis == .y ? size : 1.0 - yPadding,
                                                   z: axis == .z ? size : 1.0 - zPadding))
                
                position += size + positivePadding
                
            }
            
            let subNode = object.node(frame: frame +* subFrame)
            node.addChildNode(subNode)
            
            if UI3Defaults.debug {
                let box = SCNBox(width: frame.size.x, height: frame.size.y, length: frame.size.z, chamferRadius: 0.0)
                if #available(iOS 11.0, *) {
                    box.firstMaterial!.fillMode = .lines
                }
                box.firstMaterial!.diffuse.contents = UIColor(hue: .random(in: 0.0...1.0), saturation: 1.0, brightness: 1.0, alpha: 1.0)
                let boxNode = SCNNode(geometry: box)
                boxNode.position = frame.position.scnVector3
                node.addChildNode(boxNode)
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
    
}
