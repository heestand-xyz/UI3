#if os(macOS)
import AppKit
#else
import UIKit
#endif

#if os(macOS)
public typealias _Color = NSColor
#else
public typealias _Color = UIColor
#endif
