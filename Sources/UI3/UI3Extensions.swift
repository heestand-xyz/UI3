//
//  UI3Extensions.swift
//  UI3
//
//  Created by Anton Heestand on 2019-09-30.
//

import CoreGraphics

extension UI3Modifier {
    
    func width(for objects: [any UI3Object]) -> CGFloat? {
        objects.reduce(nil) { result, object -> CGFloat? in
            if let v = object.width {
                let p = (object.paddingEdges.left ? object.paddingLength : 0.0) + (object.paddingEdges.right ? object.paddingLength : 0.0)
                if let r = result {
                    return max(v + p, r)
                } else {
                    return v + p
                }
            }
            return result
        }
    }
    
    func relWidth(height: CGFloat?, length: CGFloat?) -> CGFloat? {
        guard let h = height, let l = length else { return nil }
        let segments: [CGFloat?] = Stack.getSegments(for: objects, in: UI3Size(x: 0.0, y: h, z: l), on: .x)
        guard !segments.contains(nil) else { return nil }
        return segments.reduce(0.0, { $0! + $1! })
    }
    
    func height(for objects: [any UI3Object]) -> CGFloat? {
        objects.reduce(nil) { result, object -> CGFloat? in
            if let v = object.height {
                let p = (object.paddingEdges.bottom ? object.paddingLength : 0.0) + (object.paddingEdges.top ? object.paddingLength : 0.0)
                if let r = result {
                    return max(v + p, r)
                } else {
                    return v + p
                }
            }
            return result
        }
    }
    
    func relHeight(width: CGFloat?, length: CGFloat?) -> CGFloat? {
        guard let w = width, let l = length else { return nil }
        let segments: [CGFloat?] = Stack.getSegments(for: objects, in: UI3Size(x: w, y: 0.0, z: l), on: .y)
        guard !segments.contains(nil) else { return nil }
        return segments.reduce(0.0, { $0! + $1! })
    }
    
    func length(for objects: [any UI3Object]) -> CGFloat? {
        objects.reduce(nil) { result, object -> CGFloat? in
            if let v = object.length {
                let p = (object.paddingEdges.far ? object.paddingLength : 0.0) + (object.paddingEdges.near ? object.paddingLength : 0.0)
                if let r = result {
                    return max(v + p, r)
                } else {
                    return v + p
                }
            }
            return result
        }
    }
    
    func relLength(width: CGFloat?, height: CGFloat?) -> CGFloat? {
        guard let w = width, let h = height else { return nil }
        let segments: [CGFloat?] = Stack.getSegments(for: objects, in: UI3Size(x: w, y: h, z: 0.0), on: .z)
        guard !segments.contains(nil) else { return nil }
        return segments.reduce(0.0, { $0! + $1! })
    }
    
}

extension UI3Object {
    
    static func getSize(on axis: UI3Axis, for object: UI3Object, in size: UI3Size) -> CGFloat? {
        var totalSize: CGFloat?
        switch axis {
        case .x: totalSize = object.width
        case .y: totalSize = object.height
        case .z: totalSize = object.length
        }
        if totalSize == nil {
            if let model = object as? UI3Model {
                switch axis {
                case .x:
                    let aspectY = model.aspectWidth / model.aspectHeight
                    let sizeY = size.y * aspectY
                    let aspectZ = model.aspectWidth / model.aspectLength
                    let sizeZ = size.z * aspectZ
                    totalSize = min(sizeY, sizeZ, 1.0)
                case .y:
                    let aspectX = model.aspectHeight / model.aspectWidth
                    let sizeX = size.x * aspectX
                    let aspectZ = model.aspectHeight / model.aspectLength
                    let sizeZ = size.z * aspectZ
                    totalSize = min(sizeX, sizeZ, 1.0)
                case .z:
                    let aspectX = model.aspectLength / model.aspectWidth
                    let sizeX = size.x * aspectX
                    let aspectY = model.aspectLength / model.aspectHeight
                    let sizeY = size.y * aspectY
                    totalSize = min(sizeX, sizeY, 1.0)
                }
            }
        }
        if totalSize != nil {
            switch axis {
            case .x: totalSize! += (object.paddingEdges.left ? object.paddingLength : 0.0) + (object.paddingEdges.right ? object.paddingLength : 0.0)
            case .y: totalSize! += (object.paddingEdges.bottom ? object.paddingLength : 0.0) + (object.paddingEdges.top ? object.paddingLength : 0.0)
            case .z: totalSize! += (object.paddingEdges.far ? object.paddingLength : 0.0) + (object.paddingEdges.near ? object.paddingLength : 0.0)
            }
        }
        return totalSize
    }
    
}

