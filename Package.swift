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
    ],
    targets: [
        .target(
            name: "DataStructure"),
        .target(
            name: "coursera-Algorithm"
        ),
        .target(
            name: "Swifter"
        ),
        .executableTarget(
            name: "RunTest",
            dependencies: [
                "DataStructure"
            ]
        ),
        .testTarget(
            name: "DataStructureTests",
            dependencies: ["DataStructure"]),
    ]
)
