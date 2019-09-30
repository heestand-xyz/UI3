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
    
}
