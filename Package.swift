// swift-tools-version: 5.9
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
            targets: ["coursera-Algorithm"]
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
            name: "coursera-Algorithm",
            dependencies: [
                .product(name: "Collections", package: "swift-collections")
            ]
        ),
        .executableTarget(
            name: "RunTest",
            dependencies: [
                "DataStructure",
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
            name: "DataStructureTests",
            dependencies: ["DataStructure"]),
    ]
)
