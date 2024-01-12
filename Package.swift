// swift-tools-version:5.9

import PackageDescription

let package = Package(
  name: "NanoID",
  platforms: [
    .iOS(.v12),
    .tvOS(.v12),
    .macOS(.v10_13),
    .watchOS(.v4)
  ],
  products: [
    .library(name: "NanoID", targets: ["NanoID"])
  ],
  targets: [
    .target(name: "NanoID", dependencies: []),
    .testTarget(name: "NanoIDTests", dependencies: ["NanoID"])
  ]
)
