// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "RomanNumeralKit",
    platforms: [
        .macOS(.v10_12),
        .iOS(.v10),
        .tvOS(.v10),
        .watchOS(.v3),
    ],
    products: [
        .library(
            name: "RomanNumeralKit",
            targets: [
                "RomanNumeralKit",
            ]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "RomanNumeralKit",
            dependencies: [
            ],
            exclude: [
                "Info.plist",
            ]
        ),
        .testTarget(
            name: "RomanNumeralKitTests",
            dependencies: [
                "RomanNumeralKit",
            ],
            exclude: [
                "Info.plist",
            ]
        ),
    ],
    swiftLanguageVersions: [
        .v5,
    ]
)
