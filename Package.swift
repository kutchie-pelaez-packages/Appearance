// swift-tools-version:5.3.0

import PackageDescription

let package = Package(
    name: "Appearance",
    platforms: [
        .iOS("15")
    ],
    products: [
        .library(
            name: "Appearance",
            targets: [
                "Appearance"
            ]
        ),
        .library(
            name: "AppearanceTweaking",
            targets: [
                "AppearanceTweaking"
            ]
        ),
        .library(
            name: "AppearanceManagerImpl",
            targets: [
                "AppearanceManagerImpl"
            ]
        )
    ],
    dependencies: [
        .package(name: "Core", url: "https://github.com/kutchie-pelaez-packages/Core.git", .branch("master")),
        .package(name: "Logging", url: "https://github.com/kutchie-pelaez-packages/Logging.git", .branch("master")),
        .package(name: "Tweaking", url: "https://github.com/kutchie-pelaez-packages/Tweaking.git", .branch("master"))
    ],
    targets: [
        .target(
            name: "AppearanceManagerImpl",
            dependencies: [
                .product(name: "Core", package: "Core"),
                .product(name: "Logger", package: "Logging"),
                .product(name: "Tweaking", package: "Tweaking"),
                .target(name: "Appearance"),
                .target(name: "AppearanceTweaking")
            ]
        ),
        .target(
            name: "AppearanceTweaking",
            dependencies: [
                .product(name: "Tweaking", package: "Tweaking")
            ]
        ),
        .target(
            name: "Appearance",
            dependencies: [
                .product(name: "Core", package: "Core")
            ]
        )
    ]
)
