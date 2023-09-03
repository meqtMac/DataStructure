// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DataStructure",
    platforms: [
        .macOS(.v13),
        .iOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "DataStructure",
            targets: ["DataStructure"]),
        .library(
            name: "Algorithm",
            targets: ["Algorithm"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-collections.git", branch: "release/1.1"),
        .package(url: "https://github.com/apple/swift-argument-parser.git", .upToNextMajor(from: "1.2.3"))
    ],
    targets: [
        .target(
            name: "DataStructure"
        ),
        .target(
            name: "Algorithm",
            dependencies: [
                .product(name: "Collections", package: "swift-collections")
            ]
        ),
        .executableTarget(
            name: "RunTest",
            dependencies: [
                "DataStructure",
                "Algorithm",
                .product(name: "Collections", package: "swift-collections")
            ]
        ),
        .executableTarget(
            name: "Percolation",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
        .testTarget(
            name: "PercolationTests",
            dependencies: ["Percolation"],
            swiftSettings: [.unsafeFlags(["-O"])]
        ),
        .testTarget(
            name: "DataStructureTests",
            dependencies: ["DataStructure"],
            swiftSettings: [.unsafeFlags(["-O"])]
        ),
    ]
)
