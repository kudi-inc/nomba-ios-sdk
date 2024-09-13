// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Octane",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Octane",
            targets: ["Octane"]),
    ],
    dependencies: [
        .package(url: "https://github.com/omaralbeik/Drops.git", from: "1.7.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Octane",
            dependencies: [
                .product(name: "Drops", package: "Drops")
            ]
        ),
        .testTarget(
            name: "OctaneTests",
            dependencies: ["Octane"]),
    ]
)
