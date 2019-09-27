import SwiftUI

@available(iOS 13.0.0, *)
public struct UI3: UIViewRepresentable {
    let objects: [UI3Object]
    public init(_ object: () -> (UI3Object)) {
        self.objects = [object()]
    }
    public init(@UI3Builder _ objects: () -> ([UI3Object])) {
        self.objects = objects()
    }
    public func makeUIView(context: Context) -> UI3View {
        return UI3View(objects: objects)
    }
    public func updateUIView(_ pixView: UI3View, context: Context) {}
}

@_functionBuilder
public struct UI3Builder {
    public static func buildBlock(_ children: UI3Object...) -> [UI3Object] {
        return children
    }
}
