//
//  UI3Types.swift
//  UI3
//
//  Created by Hexagons on 2019-09-27.
//

import SceneKit

public enum UI3Axis {
    case x
    case y
    case z
}

typealias UI3Scale = UI3Vector
typealias UI3Position = UI3Vector
public struct UI3Vector {
    let x: CGFloat
    let y: CGFloat
    let z: CGFloat
    static var zero: UI3Vector {
        return UI3Vector(x: 0.0, y: 0.0, z: 0.0)
    }
    
    static func + (lhs: UI3Vector, rhs: UI3Vector) -> UI3Vector {
        UI3Vector(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
    }
    static func + (lhs: UI3Vector, rhs: CGFloat) -> UI3Vector {
        UI3Vector(x: lhs.x + rhs, y: lhs.y + rhs, z: lhs.z + rhs)
    }
    static func + (lhs: CGFloat, rhs: UI3Vector) -> UI3Vector {
        UI3Vector(x: lhs + rhs.x, y: lhs + rhs.y, z: lhs + rhs.z)
    }
    
    static func - (lhs: UI3Vector, rhs: UI3Vector) -> UI3Vector {
        UI3Vector(x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z)
    }
    static func - (lhs: UI3Vector, rhs: CGFloat) -> UI3Vector {
        UI3Vector(x: lhs.x - rhs, y: lhs.y - rhs, z: lhs.z - rhs)
    }
    static func - (lhs: CGFloat, rhs: UI3Vector) -> UI3Vector {
        UI3Vector(x: lhs - rhs.x, y: lhs - rhs.y, z: lhs - rhs.z)
    }
    
    static func * (lhs: UI3Vector, rhs: UI3Vector) -> UI3Vector {
        UI3Vector(x: lhs.x * rhs.x, y: lhs.y * rhs.y, z: lhs.z * rhs.z)
    }
    static func * (lhs: UI3Vector, rhs: CGFloat) -> UI3Vector {
        UI3Vector(x: lhs.x * rhs, y: lhs.y * rhs, z: lhs.z * rhs)
    }
    static func * (lhs: CGFloat, rhs: UI3Vector) -> UI3Vector {
        UI3Vector(x: lhs * rhs.x, y: lhs * rhs.y, z: lhs * rhs.z)
    }
    
    static func / (lhs: UI3Vector, rhs: UI3Vector) -> UI3Vector {
        UI3Vector(x: lhs.x / rhs.x, y: lhs.y / rhs.y, z: lhs.z / rhs.z)
    }
    static func / (lhs: UI3Vector, rhs: CGFloat) -> UI3Vector {
        UI3Vector(x: lhs.x / rhs, y: lhs.y / rhs, z: lhs.z / rhs)
    }
    static func / (lhs: CGFloat, rhs: UI3Vector) -> UI3Vector {
        UI3Vector(x: lhs / rhs.x, y: lhs / rhs.y, z: lhs / rhs.z)
    }
    
}
public struct UI3Frame {
    let origin: UI3Position
    let size: UI3Scale
    init(position: UI3Position, size: UI3Scale) {
        origin = position - size / 2
        self.size = size
    }
    var position: UI3Position {
        origin + (size / 2)
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
