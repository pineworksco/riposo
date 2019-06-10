// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Riposo",
    products: [
        .library(
            name: "Riposo",
            targets: ["Riposo"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Riposo",
            dependencies: []),
        .testTarget(
            name: "RiposoTests",
            dependencies: ["Riposo"]),
    ]
)
