// swift-tools-version:5.3.0

import PackageDescription

let package = Package(
    name: "Appearance",
    platforms: [
        .iOS("15")
    ],
    products: [
        .library(
            name: "AppearanceManager", 
            targets: [
                "AppearanceManager"
            ]
        ),
        .library(
            name: "AppearanceStyle",
            targets: [
                "AppearanceStyle"
            ]
        )
    ],
    dependencies: [
        .package(name: "Core", url: "https://github.com/kutchie-pelaez-packages/Core.git", .branch("master")),
        .package(name: "Logging", url: "https://github.com/kutchie-pelaez-packages/Logging.git", .branch("master")),
        .package(name: "Tweaks", url: "https://github.com/kutchie-pelaez-packages/Tweaks.git", .branch("master"))
    ],
    targets: [
        .target(
            name: "AppearanceManager",
            dependencies: [
                .product(name: "Core", package: "Core"),
                .product(name: "Logger", package: "Logging"),
                .product(name: "Tweak", package: "Tweaks"),
                .target(name: "AppearanceStyle")
            ]
        ),
        .target(
            name: "AppearanceStyle",
            dependencies: [
                .product(name: "Core", package: "Core"),
                .product(name: "Tweak", package: "Tweaks")
            ]
        )
    ]
)
