// swift-tools-version:5.7

import PackageDescription

let package = Package(
  name: "RickAndMortyAPI",
  platforms: [
    .iOS(.v12),
    .macOS(.v10_14),
    .tvOS(.v12),
    .watchOS(.v5),
  ],
  products: [
    .library(name: "RickAndMortyAPI", targets: ["RickAndMortyAPI"]),
    .library(name: "RickAndMortyAPITestMocks", targets: ["RickAndMortyAPITestMocks"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apollographql/apollo-ios.git", from: "1.0.0"),
  ],
  targets: [
    .target(
      name: "RickAndMortyAPI",
      dependencies: [
        .product(name: "ApolloAPI", package: "apollo-ios"),
      ],
      path: "./Sources"
    ),
    .target(
      name: "RickAndMortyAPITestMocks",
      dependencies: [
        .product(name: "ApolloTestSupport", package: "apollo-ios"),
        .target(name: "RickAndMortyAPI"),
      ],
      path: "./RickAndMortyAPITestMocks"
    ),
  ]
)
