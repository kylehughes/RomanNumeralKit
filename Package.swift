// swift-tools-version:5.1

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
        .library(name: "RomanNumeralKit", targets: ["RomanNumeralKit"]),
        .executable(name: "rnk-code-gen", targets: ["RomanNumeralKitCodeGen"]),
    ],
    dependencies: [
        .package(url: "https://github.com/JohnSundell/Files", from: "4.0.0"),
        .package(url: "https://github.com/shibapm/Komondor", from: "1.0.4"),
        .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.42.0"),
        .package(url: "https://github.com/Realm/SwiftLint", from: "0.38.0"),
    ],
    targets: [
        .target(name: "RomanNumeralKit", dependencies: []),
        .target(name: "RomanNumeralKitCodeGen", dependencies: ["Files", "RomanNumeralKit"]),
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
