// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "UI3",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "UI3",
            targets: ["UI3"]),
    ],
    targets: [
        .target(
            name: "UI3",
            dependencies: []),
        .testTarget(
            name: "UI3Tests",
            dependencies: ["UI3"]),
    ]
)
