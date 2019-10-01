//
//  UI3Extensions.swift
//  UI3
//
//  Created by Anton Heestand on 2019-09-30.
//

import CoreGraphics

extension UI3Modifier {
    
    func width(for objects: [UI3Object]) -> CGFloat? {
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
    
    func height(for objects: [UI3Object]) -> CGFloat? {
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
    
    func length(for objects: [UI3Object]) -> CGFloat? {
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
