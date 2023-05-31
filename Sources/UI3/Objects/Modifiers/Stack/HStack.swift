import Foundation
import SceneKit

public struct HStack: UI3ModifierArray {
    public let name: String = "HStack"
    public var objects: [any UI3Object]
    public var width: CGFloat? { relWidth(height: height, length: length) }
    public var height: CGFloat? { height(for: objects) }
    public var length: CGFloat? { length(for: objects) }
    public var paddingEdges: UI3Edges = .none
    public var paddingLength: CGFloat = 0.0
    public init(@UI3Builder _ object: () -> (UI3Object)) {
        self.objects = [object()]
    }
    public init(@UI3Builder _ objects: () -> ([any UI3Object])) {
        self.objects = objects()
    }
    public func frames(in frame: UI3Frame) -> [UI3Frame] {
        Stack(axis: .x, objects).frames(in: frame)
    }
    public func node(frame: UI3Frame) -> SCNNode {
        Stack(axis: .x, objects).node(frame: frame)
    }
    public func frame(width: CGFloat?, height: CGFloat?, length: CGFloat?) -> UI3Object {
        return self
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
}
