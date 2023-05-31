//
//  Stack.swift
//  UI3
//
//  Created by Hexagons on 2019-09-27.
//

import SceneKit

struct Stack: UI3ModifierArray {
    
    let axis: UI3Axis?
    var objects: [any UI3Object]
    
    public let name: String = "Stack"
    public var width: CGFloat? = nil
    public var height: CGFloat? = nil
    public var length: CGFloat? = nil
    public var paddingEdges: UI3Edges = .none
    public var paddingLength: CGFloat = 0.0
    
    // MARK: - Life Cycle
    
    init(axis: UI3Axis?, _ objects: [any UI3Object]) {
        self.axis = axis
        self.objects = objects
    }
    
    init(_ objects: () -> ([UI3Object])) {
        fatalError("please use init(axis:_:)")
    }
    
    init(axis: UI3Axis?, @UI3Builder _ objects: () -> ([any UI3Object])) {
        self.axis = axis
        self.objects = objects()
    }
    
    // MARK: - Frames
    
    func frames(in frame: UI3Frame) -> [UI3Frame] {
        
        var frames: [UI3Frame] = []
        
        let allObjects = Stack.getAllObjects(from: objects)
//        if let axis = self.axis {
//            if axis == .y {
//                allObjects.reverse()
//            }
//        }

        let segments: [CGFloat?] = self.axis != nil ? Stack.getSegments(for: allObjects, in: frame.size, on: self.axis!) : []
        let totalSegments: CGFloat = segments.compactMap({$0}).reduce(0.0, { $0 + $1 })

        let leftoverTotalFraction: CGFloat = max(1.0 - totalSegments, 0.0)
        let leftoverCount: Int = segments.filter({ $0 == nil }).count
        let lefoverFraction: CGFloat = leftoverCount > 0 ? leftoverTotalFraction / CGFloat(leftoverCount) : 0.0

        var position: CGFloat = 0.0
        for object in allObjects {
            
            var subFrame: UI3Frame = .one

            var localSize: CGFloat?
            
            if let axis = self.axis {
                
                localSize = Stack.getSize(on: axis, for: object, in: frame.size)
                let size = localSize ?? lefoverFraction
                
                let xSize: CGFloat? = Stack.getSize(on: .x, for: object, in: frame.size)
                let ySize: CGFloat? = Stack.getSize(on: .y, for: object, in: frame.size)
                let zSize: CGFloat? = Stack.getSize(on: .z, for: object, in: frame.size)
                let xSizeScaled: CGFloat? = xSize != nil ? (xSize! / frame.size.x) : nil
                let ySizeScaled: CGFloat? = ySize != nil ? (ySize! / frame.size.y) : nil
                let zSizeScaled: CGFloat? = zSize != nil ? (zSize! / frame.size.z) : nil
                let xPositionScaled: CGFloat? = xSizeScaled != nil ? (frame.size.x / frame.size.x / 2 - xSizeScaled! / 2) : nil
                let yPositionScaled: CGFloat? = ySizeScaled != nil ? (frame.size.y / frame.size.y / 2 - ySizeScaled! / 2) : nil
                let zPositionScaled: CGFloat? = zSizeScaled != nil ? (frame.size.z / frame.size.z / 2 - zSizeScaled! / 2) : nil
                
                subFrame = UI3Frame(origin: UI3Position(x: axis == .x ? position / frame.size.x : xPositionScaled ?? 0.0,
                                                        y: axis == .y ? position / frame.size.y : yPositionScaled ?? 0.0,
                                                        z: axis == .z ? position / frame.size.z : zPositionScaled ?? 0.0),
                                    size: UI3Scale(x: axis == .x ? size / frame.size.x : xSizeScaled ?? 1.0,
                                                   y: axis == .y ? size / frame.size.y : ySizeScaled ?? 1.0,
                                                   z: axis == .z ? size / frame.size.z : zSizeScaled ?? 1.0))
                position += size
                
            }
            
            var finalFrame = frame +* subFrame
            if object.paddingEdges != .none {
                finalFrame = finalFrame.innerPadding(edges: object.paddingEdges, length: object.paddingLength)
            }
            
            frames.append(finalFrame)
            
        }
        
        return frames
        
    }
    
    // MARK: - Node
    
    func node(frame: UI3Frame) -> SCNNode {
        
        let node = SCNNode()
        
        if UI3Defaults.debug {
            let box = SCNBox(width: frame.size.x, height: frame.size.y, length: frame.size.z, chamferRadius: 0.0)
            box.firstMaterial!.fillMode = .lines
//            box.firstMaterial!.diffuse.contents = _Color(hue: .random(in: 0.0...1.0), saturation: 1.0, brightness: 1.0, alpha: 1.0)
            let boxNode = SCNNode(geometry: box)
            boxNode.position = frame.position.scnVector3
            node.addChildNode(boxNode)
        }
        
        let allObjects = Stack.getAllObjects(from: objects)
        let allFrames = frames(in: frame)
        
        for (i, object) in allObjects.enumerated() {
        
            let subNode = object.node(frame: allFrames[i])
            node.addChildNode(subNode)
            
            if UI3Defaults.debug {
                let box = SCNBox(width: allFrames[i].size.x, height: allFrames[i].size.y, length: allFrames[i].size.z, chamferRadius: 0.0)
                box.firstMaterial!.fillMode = .lines
//                box.firstMaterial!.diffuse.contents = _Color(hue: .random(in: 0.0...1.0), saturation: 1.0, brightness: 1.0, alpha: 1.0)
                let boxNode = SCNNode(geometry: box)
                boxNode.position = allFrames[i].position.scnVector3
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
    
    public func color(_ value: _Color) -> UI3Object {
        var object = self
        object.objects = object.objects.map({ $0.color(value) })
        return object
    }
    
    // MARK: - Segments
    
    static func getSegments(for objects: [any UI3Object], in size: UI3Size, on axis: UI3Axis) -> [CGFloat?] {
        var segments: [CGFloat?] = []
        for object in objects {
            segments.append(getSize(on: axis, for: object, in: size))
        }
        return segments
    }
    
    // MARK: - Objects
    
    static func getAllObjects(from objects: [any UI3Object]) -> [any UI3Object] {
        var allObjects: [any UI3Object] = []
        for object in objects {
            if let forEach = object as? ForEach {
                for object in forEach.objects {
                    allObjects.append(object)
                }
            } else {
                allObjects.append(object)
            }
        }
        return allObjects
    }
    
}
