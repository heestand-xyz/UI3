//
//  UI3Types.swift
//  UI3
//
//  Created by Hexagons on 2019-09-27.
//

import SceneKit

infix operator +*

public enum UI3Axis {
    case x
    case y
    case z
}

public enum UI3Edges {
    
    case all
    
    case left
    case right
    case top
    case bottom
    case far
    case near
    
    case horizontal
    case vertical
    case depth
    
    var left: Bool {
        [.all, .left, .horizontal].contains(self)
    }
    var right: Bool {
        [.all, .right, .horizontal].contains(self)
    }
    var top: Bool {
        [.all, .top, .vertical].contains(self)
    }
    var bottom: Bool {
        [.all, .bottom, .vertical].contains(self)
    }
    var far: Bool {
        [.all, .far, .depth].contains(self)
    }
    var near: Bool {
        [.all, .near, .depth].contains(self)
    }
    
    var positive: Bool {
        [.all, .horizontal, .vertical, .depth, .right, .top, .near].contains(self)
    }
    
    var negative: Bool {
        [.all, .horizontal, .vertical, .depth, .left, .bottom, .far].contains(self)
    }
    
    func on(axis: UI3Axis) -> Bool {
        switch axis {
        case .x: return left || right
        case .y: return top || bottom
        case .z: return far || near
        }
    }
    
}

public typealias UI3Scale = UI3Vector
public typealias UI3Position = UI3Vector
public struct UI3Vector: Equatable {
    
    public let x: CGFloat
    public let y: CGFloat
    public let z: CGFloat
    
    var scnVector3: SCNVector3 {
        SCNVector3(x, y, z)
    }
    
    public static var zero: UI3Vector {
        return UI3Vector(x: 0.0, y: 0.0, z: 0.0)
    }
    public static var one: UI3Vector {
        return UI3Vector(x: 1.0, y: 1.0, z: 1.0)
    }
    
    public init(x: CGFloat, y: CGFloat, z: CGFloat) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    public static func + (lhs: UI3Vector, rhs: UI3Vector) -> UI3Vector {
        UI3Vector(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
    }
    public static func + (lhs: UI3Vector, rhs: CGFloat) -> UI3Vector {
        UI3Vector(x: lhs.x + rhs, y: lhs.y + rhs, z: lhs.z + rhs)
    }
    public static func + (lhs: CGFloat, rhs: UI3Vector) -> UI3Vector {
        UI3Vector(x: lhs + rhs.x, y: lhs + rhs.y, z: lhs + rhs.z)
    }
    
    public static func - (lhs: UI3Vector, rhs: UI3Vector) -> UI3Vector {
        UI3Vector(x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z)
    }
    public static func - (lhs: UI3Vector, rhs: CGFloat) -> UI3Vector {
        UI3Vector(x: lhs.x - rhs, y: lhs.y - rhs, z: lhs.z - rhs)
    }
    public static func - (lhs: CGFloat, rhs: UI3Vector) -> UI3Vector {
        UI3Vector(x: lhs - rhs.x, y: lhs - rhs.y, z: lhs - rhs.z)
    }
    
    public static func * (lhs: UI3Vector, rhs: UI3Vector) -> UI3Vector {
        UI3Vector(x: lhs.x * rhs.x, y: lhs.y * rhs.y, z: lhs.z * rhs.z)
    }
    public static func * (lhs: UI3Vector, rhs: CGFloat) -> UI3Vector {
        UI3Vector(x: lhs.x * rhs, y: lhs.y * rhs, z: lhs.z * rhs)
    }
    public static func * (lhs: CGFloat, rhs: UI3Vector) -> UI3Vector {
        UI3Vector(x: lhs * rhs.x, y: lhs * rhs.y, z: lhs * rhs.z)
    }
    
    public static func / (lhs: UI3Vector, rhs: UI3Vector) -> UI3Vector {
        UI3Vector(x: lhs.x / rhs.x, y: lhs.y / rhs.y, z: lhs.z / rhs.z)
    }
    public static func / (lhs: UI3Vector, rhs: CGFloat) -> UI3Vector {
        UI3Vector(x: lhs.x / rhs, y: lhs.y / rhs, z: lhs.z / rhs)
    }
    public static func / (lhs: CGFloat, rhs: UI3Vector) -> UI3Vector {
        UI3Vector(x: lhs / rhs.x, y: lhs / rhs.y, z: lhs / rhs.z)
    }
    
}

public struct UI3Frame: Equatable {
    
    public let origin: UI3Position
    public let size: UI3Scale
    
    public var position: UI3Position {
        origin + (size / 2)
    }
    
    public static var one: UI3Frame {
        UI3Frame(origin: .zero, size: .one)
    }
    
    public init(origin: UI3Position, size: UI3Scale) {
        self.origin = origin
        self.size = size
    }
    public init(position: UI3Position, size: UI3Scale) {
        origin = position - size / 2
        self.size = size
    }
    
    public static func +* (lhs: UI3Frame, rhs: UI3Frame) -> UI3Frame {
        UI3Frame(origin: UI3Position(x: lhs.origin.x + rhs.origin.x,
                                     y: lhs.origin.y + rhs.origin.y,
                                     z: lhs.origin.z + rhs.origin.z),
                 size: UI3Scale(x: lhs.size.x * rhs.size.x,
                                y: lhs.size.y * rhs.size.y,
                                z: lhs.size.z * rhs.size.z))
    }
    
}

public enum UI3Shading {
    case light
    case constant
    var lightingModel: SCNMaterial.LightingModel {
        switch self {
        case .light: return .blinn
        case .constant: return .constant
        }
    }
}
