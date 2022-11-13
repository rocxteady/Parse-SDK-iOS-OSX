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
        .library(name: "ParseObjC", targets: ["ParseCore"]),
        .library(name: "ParseFacebookUtilsiOS", targets: ["ParseFacebookUtilsiOS"]),
        .library(name: "ParseFacebookUtilsTvOS", targets: ["ParseFacebookUtilsTvOS"])
    ],
    dependencies: [
        .package(url: "https://github.com/rocxteady/Bolts-ObjC", revision: "31db615d931aa7431c3f744de5fe74157e3f9cc9"),
        .package(url: "https://github.com/facebook/facebook-ios-sdk", from: "13.2.0")
    ],
    targets: [
        .target(
            name: "ParseCore",
            dependencies: [.product(name: "Bolts", package: "Bolts-ObjC")],
            path: "Parse/Parse",
//            sources: ["Source"],
            resources: [.process("Resources")],
            publicHeadersPath: "Source",
            cSettings: [.headerSearchPath("Internal/**")]),
        .target(
            name: "ParseFacebookUtils",
            dependencies: [
                "ParseCore",
                .product(name: "Bolts", package: "Bolts-ObjC"),
                .product(name: "FacebookCore", package: "facebook-ios-sdk", condition: .when(platforms: [.iOS, .tvOS])),
                .product(name: "FacebookLogin", package: "facebook-ios-sdk", condition: .when(platforms: [.iOS, .tvOS]))],
            path: "ParseFacebookUtils/ParseFacebookUtils",
//            sources: ["Source"],
            resources: [.process("Resources")],
            publicHeadersPath: "Source"),
        .target(name: "ParseFacebookUtilsiOS",
               dependencies: [
                "ParseFacebookUtils"
               ],
                path: "ParseFacebookUtilsiOS/ParseFacebookUtilsiOS",
//                sources: ["Source"],
                resources: [.process("Resources")],
                publicHeadersPath: "Source",
                cSettings: [.headerSearchPath("Internal/**")]),
        .target(name: "ParseFacebookUtilsTvOS",
               dependencies: [
                "ParseFacebookUtils",
                .product(name: "FacebookTV", package: "facebook-ios-sdk", condition: .when(platforms: [.tvOS]))
               ],
                path: "ParseFacebookUtilsTvOS/ParseFacebookUtilsTvOS",
//                sources: ["Source"],
                resources: [.process("Resources")],
                publicHeadersPath: "Source",
                cSettings: [.headerSearchPath("Internal/**")]),
    ]
)
