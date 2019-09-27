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
