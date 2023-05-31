#if os(macOS)
import AppKit
#else
import UIKit
#endif

#if os(macOS)
public typealias _View = NSView
#else
public typealias _View = UIView
#endif
