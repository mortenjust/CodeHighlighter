// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// 0.2.0

let package = Package(
    name: "CodeHighlighter",
    platforms: [.macOS(.v12), .iOS(.v15), .tvOS(.v15), .watchOS(.v8)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "CodeHighlighter",
            targets: ["CodeHighlighter"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
         .package(url: "https://github.com/mortenjust/Highlightr", branch: "master") ,
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "CodeHighlighter",
            dependencies: ["Highlightr"]),
        .testTarget(
            name: "CodeHighlighterTests",
            dependencies: ["CodeHighlighter", "Highlightr"]),
    ]
)
