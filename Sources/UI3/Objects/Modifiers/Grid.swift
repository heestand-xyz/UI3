//
//  Grid.swift
//  UI3
//
//  Created by Anton Heestand on 2019-09-30.
//

import SceneKit

public struct Grid: UI3ModifierSingle {
    public let name: String = "Grid"
    public var objects: [UI3Object]
    public var width: CGFloat? = nil
    public var height: CGFloat? = nil
    public var length: CGFloat? = nil
    public var paddingEdges: UI3Edges = .none
    public var paddingLength: CGFloat = 0.0
    var xRange: Range<Int> = 0..<3
    var yRange: Range<Int> = 0..<3
    var zRange: Range<Int> = 0..<3
    public init(_ object: () -> (UI3Object)) {
        self.objects = [object()]
    }
    public init(x xRange: Range<Int>, y yRange: Range<Int>, z zRange: Range<Int>, _ object: () -> (UI3Object)) {
        self.xRange = xRange
        self.yRange = yRange
        self.zRange = zRange
        self.objects = [object()]
    }
    public func node(frame: UI3Frame) -> SCNNode {
        HStack {
            ForEach(xRange) { _ in
                VStack {
                    ForEach(yRange) { _ in
                        ZStack {
                            ForEach(zRange) { _ in
                                objects.first!
                            }
                        }
                    }
                }
            }
        }
            .node(frame: frame)
    }
    public func frame(width: CGFloat?, height: CGFloat?, length: CGFloat?) -> UI3Object {
        return self
    }
    public func padding(edges: UI3Edges, length: CGFloat) -> UI3Object {
        return self
    }
    public func color(_ value: UIColor) -> UI3Object {
        var object = self
        object.objects = object.objects.map({ $0.color(value) })
        return object
    }
}
