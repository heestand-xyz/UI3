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
}

public struct VStack: UI3ModifierArray {
    public var objects: [UI3Object]
    public init(@UI3Builder _ objects: () -> ([UI3Object])) {
        self.objects = objects()
    }
    public func node(frame: UI3Frame) -> SCNNode {
        Stack(axis: .y, { objects }).node(frame: frame)
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
}

public struct WStack: UI3ModifierArray {
    public var objects: [UI3Object]
    public init(@UI3Builder _ objects: () -> ([UI3Object])) {
        self.objects = objects()
    }
    public func node(frame: UI3Frame) -> SCNNode {
        Stack(axis: nil, { objects }).node(frame: frame)
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
        for object in objects {
//            let frame = UI3Frame(origin: .zero, size: <#T##UI3Scale#>)
//            let subNode = object.node(frame: frame))
//            node.addChildNode(subNode)
        }
        return node
    }
    
}
