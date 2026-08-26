// swift-tools-version: 5.9
import PackageDescription

let package = Package(
  name: "AnchorKit",
  platforms: [
    .iOS(.init("14"))
  ],
  products: [
    .library(
      name: "AnchorKit",
      targets: ["AnchorKit"]
    )
  ],
  targets: [
    .target(name: "AnchorKit"),
    .testTarget(
      name: "AnchorKitTests",
      dependencies: ["AnchorKit"]
    ),
  ]
)
