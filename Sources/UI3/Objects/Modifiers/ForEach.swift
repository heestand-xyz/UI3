//
//  ForEach.swift
//  UI3
//
//  Created by Hexagons on 2019-09-29.
//

import SceneKit

public struct ForEach: UI3ModifierSingle {
    public var objects: [UI3Object]
    public var width: CGFloat? = nil
    public var height: CGFloat? = nil
    public var length: CGFloat? = nil
    public var paddingEdges: UI3Edges = .none
    public var paddingLength: CGFloat = 0.0
    public init(_ object: () -> (UI3Object)) {
        self.objects = [object()]
    }
    public init(_ range: Range<Int>, _ object: (Int) -> (UI3Object)) {
        self.objects = []
        for i in range {
            self.objects.append(object(i))
        }
    }
    public func node(frame: UI3Frame) -> SCNNode {
        return SCNNode()
    }
    public func frame(width: CGFloat?, height: CGFloat?, length: CGFloat?) -> UI3Object {
        return self
    }
    public func padding(edges: UI3Edges, length: CGFloat) -> UI3Object {
        return self
    }
}
