// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "fpingx",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_13)
    ],
    products: [
        .library(name: "fpingx", targets: ["fpingx"])
    ],
    targets: [
        .target(
            name: "Cfping",
            path: "fping",
            publicHeadersPath: ".",
            cSettings: [
                .headerSearchPath(".")
            ]
        ),
        .target(
            name: "fpingx",
            dependencies: ["Cfping"],
            path: "fpingx",
            exclude: ["fpingx.h"]
        )
    ]
)
