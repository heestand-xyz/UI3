//
//  Stack.swift
//  UI3
//
//  Created by Hexagons on 2019-09-27.
//

import SceneKit

public struct HStack: UI3ModifierArray {
    public let name: String = "HStack"
    public var objects: [UI3Object]
    public var width: CGFloat? = nil
    public var height: CGFloat? { height(for: objects) }
    public var length: CGFloat? { length(for: objects) }
    public var paddingEdges: UI3Edges = .none
    public var paddingLength: CGFloat = 0.0
    public init(@UI3Builder _ object: () -> (UI3Object)) {
        self.objects = [object()]
    }
    public init(@UI3Builder _ objects: () -> ([UI3Object])) {
        self.objects = objects()
    }
    public func node(frame: UI3Frame) -> SCNNode {
        Stack(axis: .x, { objects }).node(frame: frame)
    }
    public func frame(width: CGFloat?, height: CGFloat?, length: CGFloat?) -> UI3Object {
        var object = self
        if width != nil { object.width = width }
//        if height != nil { object.height = height }
//        if length != nil { object.length = length }
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
        object.objects = object.objects.map({ $0.color(value) })
        return object
    }
}

public struct VStack: UI3ModifierArray {
    public let name: String = "VStack"
    public var objects: [UI3Object]
    public var width: CGFloat? { width(for: objects) }
    public var height: CGFloat? = nil
    public var length: CGFloat? { length(for: objects) }
    public var paddingEdges: UI3Edges = .none
    public var paddingLength: CGFloat = 0.0
    public init(@UI3Builder _ object: () -> (UI3Object)) {
        self.objects = [object()]
    }
    public init(@UI3Builder _ objects: () -> ([UI3Object])) {
        self.objects = objects()
    }
    public func node(frame: UI3Frame) -> SCNNode {
        Stack(axis: .y, { objects }).node(frame: frame)
    }
    public func frame(width: CGFloat?, height: CGFloat?, length: CGFloat?) -> UI3Object {
        var object = self
//        if width != nil { object.width = width }
        if height != nil { object.height = height }
//        if length != nil { object.length = length }
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
        object.objects = object.objects.map({ $0.color(value) })
        return object
    }
}

public struct ZStack: UI3ModifierArray {
    public let name: String = "ZStack"
    public var objects: [UI3Object]
    public var width: CGFloat? { width(for: objects) }
    public var height: CGFloat? { height(for: objects) }
    public var length: CGFloat? = nil
    public var paddingEdges: UI3Edges = .none
    public var paddingLength: CGFloat = 0.0
    public init(@UI3Builder _ object: () -> (UI3Object)) {
        self.objects = [object()]
    }
    public init(@UI3Builder _ objects: () -> ([UI3Object])) {
        self.objects = objects()
    }
    public func node(frame: UI3Frame) -> SCNNode {
        Stack(axis: .z, { objects }).node(frame: frame)
    }
    public func frame(width: CGFloat?, height: CGFloat?, length: CGFloat?) -> UI3Object {
        var object = self
//        if width != nil { object.width = width }
//        if height != nil { object.height = height }
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
        object.objects = object.objects.map({ $0.color(value) })
        return object
    }
}

public struct WStack: UI3ModifierArray {
    public let name: String = "WStack"
    public var objects: [UI3Object]
    public var width: CGFloat? { width(for: objects) }
    public var height: CGFloat? { height(for: objects) }
    public var length: CGFloat? { length(for: objects) }
    public var paddingEdges: UI3Edges = .none
    public var paddingLength: CGFloat = 0.0
    public init(@UI3Builder _ object: () -> (UI3Object)) {
        self.objects = [object()]
    }
    public init(@UI3Builder _ objects: () -> ([UI3Object])) {
        self.objects = objects()
    }
    public func node(frame: UI3Frame) -> SCNNode {
        Stack(axis: nil, { objects }).node(frame: frame)
    }
    public func frame(width: CGFloat?, height: CGFloat?, length: CGFloat?) -> UI3Object {
        var object = self
//        if width != nil { object.width = width }
//        if height != nil { object.height = height }
//        if length != nil { object.length = length }
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
        object.objects = object.objects.map({ $0.color(value) })
        return object
    }
}

struct Stack: UI3ModifierArray {
    
    var axis: UI3Axis? = nil
    var objects: [UI3Object]
    
    public let name: String = "Stack"
    public var width: CGFloat? = nil
    public var height: CGFloat? = nil
    public var length: CGFloat? = nil
    public var paddingEdges: UI3Edges = .none
    public var paddingLength: CGFloat = 0.0
    
    // MARK: - Life Cycle
    
    public init(@UI3Builder _ object: () -> (UI3Object)) {
        self.objects = [object()]
    }
    
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
        
        var allObjects: [UI3Object] = []
        for object in objects {
            if let forEach = object as? ForEach {
                for object in forEach.objects {
                    allObjects.append(object)
                }
            } else {
                allObjects.append(object)
            }
        }
//        if let axis = self.axis {
//            if axis == .y {
//                allObjects.reverse()
//            }
//        }
        
        func getSize(on axis: UI3Axis, for object: UI3Object) -> CGFloat? {
            var size: CGFloat?
            switch axis {
            case .x: size = object.width
            case .y: size = object.height
            case .z: size = object.length
            }
            if size == nil {
                if let model = object as? UI3Model {
                    switch axis {
                    case .x:
                        let aspectY = model.aspectWidth / model.aspectHeight
                        let sizeY = frame.size.y * aspectY
                        let aspectZ = model.aspectWidth / model.aspectLength
                        let sizeZ = frame.size.z * aspectZ
                        size = min(sizeY, sizeZ)
                    case .y:
                        let aspectX = model.aspectHeight / model.aspectWidth
                        let sizeX = frame.size.x * aspectX
                        let aspectZ = model.aspectHeight / model.aspectLength
                        let sizeZ = frame.size.z * aspectZ
                        size = min(sizeX, sizeZ)
                    case .z:
                        let aspectX = model.aspectLength / model.aspectWidth
                        let sizeX = frame.size.x * aspectX
                        let aspectY = model.aspectLength / model.aspectHeight
                        let sizeY = frame.size.y * aspectY
                        size = min(sizeX, sizeY)
                    }
                }
            }
            if size != nil {
                switch axis {
                case .x: size! += (object.paddingEdges.left ? object.paddingLength : 0.0) + (object.paddingEdges.right ? object.paddingLength : 0.0)
                case .y: size! += (object.paddingEdges.bottom ? object.paddingLength : 0.0) + (object.paddingEdges.top ? object.paddingLength : 0.0)
                case .z: size! += (object.paddingEdges.far ? object.paddingLength : 0.0) + (object.paddingEdges.near ? object.paddingLength : 0.0)
                }
            }
            return size
        }
        
        var segments: [CGFloat?] = []
        if let axis = self.axis {
            for object in allObjects {
                segments.append(getSize(on: axis, for: object))
            }
        }
        let totalSegments: CGFloat = segments.compactMap({$0}).reduce(0, { $0 + $1 })
        
        let leftoverTotalFraction: CGFloat = max(1.0 - totalSegments, 0.0)
        let leftoverCount: Int = segments.filter({ $0 == nil }).count
        let lefoverFraction: CGFloat = leftoverCount > 0 ? leftoverTotalFraction / CGFloat(leftoverCount) : 0.0

        var position: CGFloat = 0.0
        for object in allObjects {
            
            var subFrame: UI3Frame = .one

            var localSize: CGFloat?
            
            if let axis = self.axis {
                
                localSize = getSize(on: axis, for: object)
                let size = localSize ?? lefoverFraction
                
                let xSize = getSize(on: .x, for: object)
                let ySize = getSize(on: .y, for: object)
                let zSize = getSize(on: .z, for: object)
                let xSizeScaled = xSize != nil ? (xSize! / frame.size.x) : nil
                let ySizeScaled = ySize != nil ? (ySize! / frame.size.y) : nil
                let zSizeScaled = zSize != nil ? (zSize! / frame.size.z) : nil
                
                subFrame = UI3Frame(origin: UI3Position(x: axis == .x ? position : 0.0,
                                                        y: axis == .y ? position : 0.0,
                                                        z: axis == .z ? position : 0.0),
                                    size: UI3Scale(x: axis == .x ? size : xSizeScaled ?? 1.0,
                                                   y: axis == .y ? size : ySizeScaled ?? 1.0,
                                                   z: axis == .z ? size : zSizeScaled ?? 1.0))
                position += size
                
            }
            
            var finalFrame = frame +* subFrame
            if object.paddingEdges != .none {
                finalFrame = finalFrame.innerPadding(edges: object.paddingEdges, length: object.paddingLength)
            }
            
            let subNode = object.node(frame: finalFrame)
            node.addChildNode(subNode)
            
            if UI3Defaults.debug {
                let box = SCNBox(width: finalFrame.size.x, height: finalFrame.size.y, length: finalFrame.size.z, chamferRadius: 0.0)
                if #available(iOS 11.0, *) {
                    box.firstMaterial!.fillMode = .lines
                }
                box.firstMaterial!.diffuse.contents = UIColor(hue: .random(in: 0.0...1.0), saturation: 1.0, brightness: 1.0, alpha: 1.0)
                let boxNode = SCNNode(geometry: box)
                boxNode.position = finalFrame.position.scnVector3
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
    
    public func color(_ value: UIColor) -> UI3Object {
        var object = self
        object.objects = object.objects.map({ $0.color(value) })
        return object
    }
    
}
