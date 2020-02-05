// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "AckeeTracker",
  products: [
    // Products define the executables and libraries produced by a package, and make them visible to other packages.
    .library(
      name: "AckeeTracker",
      targets: ["AckeeTracker"]),
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    // Dev deps
    .package(url: "https://github.com/vknabel/Archery.git", from: "0.3.0"),  // dev
    .package(url: "https://github.com/shibapm/Komondor.git", from: "1.0.4"),  // dev
    .package(url: "https://github.com/apple/swift-format.git", .branch("swift-5.1-branch")),  // dev
    .package(url: "https://github.com/f-meloni/Rocket.git", from: "0.1.0"),  // dev
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages which this package depends on.
    .target(
      name: "AckeeTracker",
      dependencies: []),
    .testTarget(
      name: "AckeeTrackerTests",
      dependencies: ["AckeeTracker"]),
  ]
)

#if canImport(PackageConfig)
  import PackageConfig

  let config = PackageConfiguration([
    "komondor": [
      "pre-push": "swift test",
      "pre-commit": [
        "swift test",
        "swift run archery format",
        "swift run archery docs",
        "git add ."
      ]
    ],
  ]).write()
#endif
