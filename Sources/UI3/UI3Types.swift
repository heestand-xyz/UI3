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

public enum UI3Plane {
    case xy
    case yz
    case xz
    var axes: (UI3Axis, UI3Axis) {
        switch self {
        case .xy: return (.x, .y)
        case .yz: return (.y, .z)
        case .xz: return (.x, .z)
        }
    }
}

public enum UI3Edges {
    
    case none
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
        case .y: return top || bottom
        case .z: return far || near
        }
    }
    
}

public typealias UI3Scale = UI3Vector
public typealias UI3Size = UI3Vector
public typealias UI3Position = UI3Vector
public typealias UI3Rotation = UI3Vector
public struct UI3Vector: Equatable {
    
    public var x: CGFloat
    public var y: CGFloat
    public var z: CGFloat
    
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
    
    func value(on axis: UI3Axis) -> CGFloat {
        switch axis {
        case .x: return x
        case .y: return y
        case .z: return z
        }
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
    public static func += (lhs: inout UI3Vector, rhs: UI3Vector) {
        lhs = lhs + rhs
    }
    public static func += (lhs: inout UI3Vector, rhs: CGFloat) {
        lhs = lhs + rhs
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
    public static func -= (lhs: inout UI3Vector, rhs: UI3Vector) {
        lhs = lhs - rhs
    }
    public static func -= (lhs: inout UI3Vector, rhs: CGFloat) {
        lhs = lhs - rhs
    }
    public prefix static func - (operand: UI3Vector) -> UI3Vector {
        UI3Vector(x: -operand.x, y: -operand.y, z: -operand.z)
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
    public static func *= (lhs: inout UI3Vector, rhs: UI3Vector) {
        lhs = lhs * rhs
    }
    public static func *= (lhs: inout UI3Vector, rhs: CGFloat) {
        lhs = lhs * rhs
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
    public static func /= (lhs: inout UI3Vector, rhs: UI3Vector) {
        lhs = lhs / rhs
    }
    public static func /= (lhs: inout UI3Vector, rhs: CGFloat) {
        lhs = lhs / rhs
    }
    
}

public typealias UI3Bounds = UI3Frame
public struct UI3Frame: Equatable {
    
    public var origin: UI3Position
    public var size: UI3Scale
    
    public var position: UI3Position {
        origin + (size / 2)
    }
    
    public static var one: UI3Frame {
        UI3Frame(origin: .zero, size: .one)
    }
    
    public var minX: CGFloat {
        origin.x + size.x
    }
    public var minY: CGFloat {
        origin.y + size.y
    }
    public var minZ: CGFloat {
        origin.z + size.z
    }
    public var maxX: CGFloat {
        origin.x + size.x
    }
    public var maxY: CGFloat {
        origin.y + size.y
    }
    public var maxZ: CGFloat {
        origin.z + size.z
    }
    
    public var width: CGFloat {
        size.x
    }
    public var height: CGFloat {
        size.y
    }
    public var length: CGFloat {
        size.z
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
        UI3Frame(origin: lhs.origin + rhs.origin * lhs.size, size: lhs.size * rhs.size)
    }
    
    public func innerPadding(edges: UI3Edges, length: CGFloat) -> UI3Frame {
        return UI3Frame(origin: UI3Position(x: origin.x + (edges.left ? length : 0.0),
                                            y: origin.y + (edges.bottom ? length : 0.0),
                                            z: origin.z + (edges.far ? length : 0.0)),
                        size: UI3Scale(x: size.x - (edges.left ? length : 0.0) - (edges.right ? length : 0.0),
                                       y: size.y - (edges.bottom ? length : 0.0) - (edges.top ? length : 0.0),
                                       z: size.z - (edges.far ? length : 0.0) - (edges.near ? length : 0.0)))
    }
    
    public func outerPadding(edges: UI3Edges, length: CGFloat) -> UI3Frame {
        return UI3Frame(origin: UI3Position(x: origin.x - (edges.left ? length : 0.0),
                                            y: origin.y - (edges.bottom ? length : 0.0),
                                            z: origin.z - (edges.far ? length : 0.0)),
                        size: UI3Scale(x: size.x + (edges.left ? length : 0.0) + (edges.right ? length : 0.0),
                                       y: size.y + (edges.bottom ? length : 0.0) + (edges.top ? length : 0.0),
                                       z: size.z + (edges.far ? length : 0.0) + (edges.near ? length : 0.0)))
    }
    
    func contains(_ position: UI3Position) -> Bool {
        origin.x < position.x && origin.x + size.x > position.x &&
        origin.y < position.y && origin.y + size.y > position.y &&
        origin.z < position.z && origin.z + size.z > position.z
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
