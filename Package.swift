// swift-tools-version:5.3.0

import PackageDescription

let package = Package(
    name: "AppearanceManager",
    platforms: [
        .iOS("15")
    ],
    products: [
        .library(name: "AppearanceManager", targets: ["AppearanceManager"]),
        .library(name: "AppearanceStyle", targets: ["AppearanceStyle"])
    ],
    dependencies: [
        .package(name: "CoreUtils", url: "https://github.com/kutchie-pelaez-packages/CoreUtils", .branch("master"))
    ],
    targets: [
        .target(
            name: "AppearanceManager",
            dependencies: [
                .product(name: "CoreUtils", package: "CoreUtils"),
                .target(name: "AppearanceStyle")
            ]
        ),
        .target(
            name: "AppearanceStyle",
            dependencies: [
                .product(name: "CoreUtils", package: "CoreUtils")
            ]
        )
    ]
)
