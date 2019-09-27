//
//  Stack.swift
//  UI3
//
//  Created by Hexagons on 2019-09-27.
//

import SceneKit

public struct HStack: UI3ModifierArray {
    public var objects: [UI3Object]
    public init(@UI3Builder _ objects: () -> ([UI3Object])) {
        self.objects = objects()
    }
    public func node(frame: UI3Frame) -> SCNNode {
        Stack(axis: .x, { objects }).node(frame: frame)
    }
    public func frame(_ frame: UI3Frame) -> UI3Object {
        return self
    }
}

public struct VStack: UI3ModifierArray {
    public var objects: [UI3Object]
    public init(@UI3Builder _ objects: () -> ([UI3Object])) {
        self.objects = objects()
    }
    public func node(frame: UI3Frame) -> SCNNode {
        Stack(axis: .y, { objects }).node(frame: frame)
    }
    public func frame(_ frame: UI3Frame) -> UI3Object {
        return self
    }
}

public struct ZStack: UI3ModifierArray {
    public var objects: [UI3Object]
    public init(@UI3Builder _ objects: () -> ([UI3Object])) {
        self.objects = objects()
    }
    public func node(frame: UI3Frame) -> SCNNode {
        Stack(axis: .z, { objects }).node(frame: frame)
    }
    public func frame(_ frame: UI3Frame) -> UI3Object {
        return self
    }
}

public struct WStack: UI3ModifierArray {
    public var objects: [UI3Object]
    public init(@UI3Builder _ objects: () -> ([UI3Object])) {
        self.objects = objects()
    }
    public func node(frame: UI3Frame) -> SCNNode {
        Stack(axis: nil, { objects }).node(frame: frame)
    }
    public func frame(_ frame: UI3Frame) -> UI3Object {
        return self
    }
}

struct Stack: UI3ModifierArray {
    
    var axis: UI3Axis? = nil
    var objects: [UI3Object]
    
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
        for (i, object) in objects.enumerated() {
            var subFrame: UI3Frame = .one
            if let axis = self.axis {
                let positionFraction = CGFloat(i) / CGFloat(objects.count)
                let sizeFraction = 1.0 / CGFloat(objects.count)
                subFrame = UI3Frame(origin: UI3Position(x: axis == .x ? positionFraction : 0.0,
                                                     y: axis == .y ? positionFraction : 0.0,
                                                     z: axis == .z ? positionFraction : 0.0),
                                 size: UI3Scale(x: axis == .x ? sizeFraction : 1.0,
                                                y: axis == .y ? sizeFraction : 1.0,
                                                z: axis == .z ? sizeFraction : 1.0))
            }
            let subNode = object.node(frame: frame +* subFrame)
            node.addChildNode(subNode)
        }
        return node
    }
    
    // MARK: - Frame
    
    public func frame(_ frame: UI3Frame) -> UI3Object {
        return self
    }
    
}
