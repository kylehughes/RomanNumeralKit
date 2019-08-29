// swift-tools-version:5.0

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
        .library(name: "RomanNumeralKit", type: .dynamic, targets: ["RomanNumeralKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.40.11"),
        .package(url: "https://github.com/Realm/SwiftLint", from: "0.34.0"),
        .package(url: "https://github.com/orta/Komondor", from: "1.0.4"),
    ],
    targets: [
        .target(name: "RomanNumeralKit", dependencies: []),
        .testTarget(name: "RomanNumeralKitTests", dependencies: ["RomanNumeralKit"]),
    ],
    swiftLanguageVersions: [
        .v5,
    ]
)

#if canImport(PackageConfig)
    import PackageConfig

    let config = PackageConfiguration([
        "komondor": [
            "pre-push": "swift test",
            "pre-commit": [
                "swift run swiftformat .",
                "swift run swiftlint autocorrect --path Sources/",
                "git add .",
            ],
        ],
    ]).write()
#endif
