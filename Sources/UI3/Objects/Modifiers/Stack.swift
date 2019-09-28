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
}

public struct VStack: UI3ModifierArray {
    public var objects: [UI3Object]
    public var width: CGFloat? = nil
    public var height: CGFloat? = nil
    public var length: CGFloat? = nil
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
}

public struct ZStack: UI3ModifierArray {
    public var objects: [UI3Object]
    public var width: CGFloat? = nil
    public var height: CGFloat? = nil
    public var length: CGFloat? = nil
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
}

public struct WStack: UI3ModifierArray {
    public var objects: [UI3Object]
    public var width: CGFloat? = nil
    public var height: CGFloat? = nil
    public var length: CGFloat? = nil
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
}

struct Stack: UI3ModifierArray {
    
    var axis: UI3Axis? = nil
    var objects: [UI3Object]
    
    public var width: CGFloat? = nil
    public var height: CGFloat? = nil
    public var length: CGFloat? = nil
    
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
                switch axis {
                case .x: segments.append(object.width)
                case .y: segments.append(object.height)
                case .z: segments.append(object.length)
                }
            }
        }
        let totalSegments: CGFloat = segments.compactMap({$0}).reduce(0, { $0 + $1 })
        let leftoverTotalFraction: CGFloat = max(1.0 - totalSegments, 0.0)
        let leftoverCount: Int = segments.filter({ $0 == nil }).count
        let lefoverFraction: CGFloat? = leftoverCount > 0 ? leftoverTotalFraction / CGFloat(leftoverCount) : nil
        var position: CGFloat = 0.0
        for object in objects {
            var subFrame: UI3Frame = .one
            if let axis = self.axis {
                let size: CGFloat = {
                    switch axis {
                    case .x: return object.width
                    case .y: return object.height
                    case .z: return object.length
                    }
                }() ?? lefoverFraction!
//                let positionFraction = CGFloat(i) / CGFloat(objects.count)
//                let sizeFraction = 1.0 / CGFloat(objects.count)
                subFrame = UI3Frame(origin: UI3Position(x: axis == .x ? position : 0.0,
                                                     y: axis == .y ? position : 0.0,
                                                     z: axis == .z ? position : 0.0),
                                 size: UI3Scale(x: axis == .x ? size : 1.0,
                                                y: axis == .y ? size : 1.0,
                                                z: axis == .z ? size : 1.0))
                position += size
            }
            let subNode = object.node(frame: frame +* subFrame)
            node.addChildNode(subNode)
        }
        return node
    }
    
    // MARK: - Frame
    
    public func frame(width: CGFloat?, height: CGFloat?, length: CGFloat?) -> UI3Object {
        var object = self
        if width != nil { object.width = width }
        if height != nil { object.height = height }
        if length != nil { object.length = length }
        return object
    }
    
}
