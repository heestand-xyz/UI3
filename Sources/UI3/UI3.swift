import SwiftUI

@available(iOS 13.0.0, *)
public struct UI3: UIViewRepresentable {
    let object: UI3Object
    public init(_ object: () -> (UI3Object)) {
        self.object = object()
    }
    public func makeUIView(context: Context) -> UI3View {
        return UI3View(object: object)
    }
    public func updateUIView(_ pixView: UI3View, context: Context) {}
}

@_functionBuilder
public struct UI3Builder {
    public static func buildBlock(_ child: UI3Object) -> UI3Object {
        return child
    }
    public static func buildBlock(_ children: UI3Object...) -> [UI3Object] {
        return children
    }
}

public struct UI3Defaults {
    public static var debug = false
    public static var wireframe = false
    public static var orthoCamera = false
//    public static var paddingLength: CGFloat = 0.025
}
