// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "ParseObjC",
    defaultLocalization: "en",
    platforms: [.iOS(.v9),
                .macOS(.v10_10),
                .tvOS(.v10),
                .watchOS(.v2)],
    products: [
        .library(name: "ParseObjC", targets: ["ParseCore"])
    ],
    dependencies: [
        .package(url: "https://github.com/rocxteady/Bolts-ObjC", revision: "31db615d931aa7431c3f744de5fe74157e3f9cc9")
    ],
    targets: [
        .target(
            name: "ParseCore",
            dependencies: [.product(name: "Bolts", package: "Bolts-ObjC")],
            path: "Parse/Parse",
            resources: [.process("Resources")],
            publicHeadersPath: "",
            cSettings: [.headerSearchPath("Internal/**")]),
    ]
)
