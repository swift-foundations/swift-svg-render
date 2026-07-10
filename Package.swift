// swift-tools-version: 6.3.3

import PackageDescription

extension String {
    static let svgRendering: Self = "SVG Rendering"
    var tests: Self { self + " Tests" }
}

extension Target.Dependency {
    static var svgRendering: Self { .target(name: .svgRendering) }
}

extension Target.Dependency {
    static var renderingPrimitives: Self {
        .product(name: "Render Primitives", package: "swift-render-primitives")
    }
    static var svgStandard: Self {
        .product(name: "SVG Standard", package: "swift-svg-standard")
    }
    static var asciiPrimitives: Self {
        .product(name: "ASCII Primitives", package: "swift-ascii-primitives")
    }
    static var formatting: Self {
        .product(name: "Format Primitives", package: "swift-format-primitives")
    }
    static var dimension: Self {
        .product(name: "Dimension Primitives", package: "swift-dimension-primitives")
    }
    static var dictionaryPrimitives: Self {
        .product(name: "Dictionary Primitives", package: "swift-dictionary-primitives")
    }
    static var sharedPrimitive: Self {
        .product(name: "Ownership Shared Primitive", package: "swift-ownership-shared-primitives")
    }
    static var hashIndexedPrimitive: Self {
        .product(name: "Hash Indexed Primitive", package: "swift-hash-table-primitives")
    }
    static var columnPrimitives: Self {
        .product(name: "Column Primitives", package: "swift-column-primitives")
    }
    static var hashPrimitives: Self {
        .product(name: "Hash Primitives", package: "swift-hash-primitives")
    }
    static var bufferLinearPrimitive: Self {
        .product(name: "Buffer Linear Primitive", package: "swift-buffer-linear-primitives")
    }
}

let package = Package(
    name: "swift-svg-render",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26),
    ],
    products: [
        .library(name: .svgRendering, targets: [.svgRendering]),
        .library(name: "SVG Rendering Test Support", targets: ["SVG Rendering Test Support"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-primitives/swift-render-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-standards/swift-svg-standard.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-format-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-dimension-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-ascii-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-dictionary-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-dictionary-ordered-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-ownership-shared-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-hash-table-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-column-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-hash-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-buffer-linear-primitives.git", branch: "main"),
    ],
    targets: [
        .target(
            name: .svgRendering,
            dependencies: [
                .renderingPrimitives,
                .svgStandard,
                .asciiPrimitives,
                .formatting,
                .dimension,
                .dictionaryPrimitives,
                .product(name: "Dictionary Ordered Primitives", package: "swift-dictionary-ordered-primitives"),
                .sharedPrimitive,
                .hashIndexedPrimitive,
                .columnPrimitives,
                .hashPrimitives,
                .bufferLinearPrimitive,
            ]
        ),
        .target(
            name: "SVG Rendering Test Support",
            dependencies: [
                .svgRendering,
                .product(name: "Dimension Primitives Test Support", package: "swift-dimension-primitives"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: .svgRendering.tests,
            dependencies: [
                .svgRendering,
                "SVG Rendering Test Support",
            ],
            path: "Tests/SVG Rendering Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
