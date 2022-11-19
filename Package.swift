// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "ParseObjC",
    defaultLocalization: "en",
    platforms: [.iOS(.v12),
                .macOS(.v10_10),
                .tvOS(.v12),
                .watchOS(.v2)],
    products: [
        .library(name: "ParseObjC", targets: ["ParseCore"]),
        .library(name: "ParseFacebookUtilsiOS", targets: ["ParseFacebookUtilsiOS"]),
        .library(name: "ParseFacebookUtilsTvOS", targets: ["ParseFacebookUtilsTvOS"]),
        .library(name: "ParseTwitterUtils", targets: ["ParseTwitterUtils"])
    ],
    dependencies: [
        .package(url: "https://github.com/rocxteady/Bolts-ObjC", revision: "0419586ce3df0a004fbf94533198132de9c9aa0a"),
        .package(url: "https://github.com/facebook/facebook-ios-sdk", from: "15.1.0")
    ],
    targets: [
        .target(
            name: "ParseCore",
            dependencies: [.product(name: "Bolts", package: "Bolts-ObjC")],
            path: "Parse/Parse",
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
            exclude: ["exclude"],
            resources: [.process("Resources")],
            publicHeadersPath: "Source"),
        .target(name: "ParseFacebookUtilsiOS",
               dependencies: [
                "ParseFacebookUtils"
               ],
                path: "ParseFacebookUtilsiOS/ParseFacebookUtilsiOS",
                exclude: ["exclude"],
                resources: [.process("Resources")],
                publicHeadersPath: "Source",
                cSettings: [.headerSearchPath("Internal/**")]),
        .target(name: "ParseFacebookUtilsTvOS",
               dependencies: [
                "ParseFacebookUtils",
                .product(name: "FacebookTV", package: "facebook-ios-sdk", condition: .when(platforms: [.tvOS]))
               ],
                path: "ParseFacebookUtilsTvOS/ParseFacebookUtilsTvOS",
                exclude: ["exclude"],
                resources: [.process("Resources")],
                publicHeadersPath: "Source",
                cSettings: [.headerSearchPath("Internal/**")]),
        .target(name: "ParseTwitterUtils",
               dependencies: [
                "ParseCore"
               ],
                path: "ParseTwitterUtils/ParseTwitterUtils",
//                exclude: ["exclude"],
                resources: [.process("Resources")],
                publicHeadersPath: "Source",
                cSettings: [.headerSearchPath("Internal/**")]),
    ]
)
