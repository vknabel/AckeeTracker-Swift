# AckeeTracker

A script that interacts with the REST API of [Ackee](https://github.com/electerious/Ackee). Should be used to feed your server with data from your App's users.

## Requirements

AckeeTracker requires a running [Ackee server](https://github.com/electerious/Ackee).

## Installation

AckeeTracker has no external dependencies and supports [Swift Package Manager](https://github.com/apple/swift-package-manager).

### Swift Package Manager

```swift
import PackageDescription

let package = Package(
    name: "YourPackage",
    dependencies: [
        .package(url: "https://github.com/vknabel/AckeeTracker.git", from: "0.1.0")
    ],
    targets: [
        .target(name: "YourTarget", dependencies: ["AckeeTracker"]),
    ]
)
```

## Usage

```swift
import AckeeTracker

let ackee: Tracker = AckeeTracker(
  configuration: AckeeConfiguration(
    domainId: "<your-domain-id>",
    serverUrl: URL(string: "https://ackee.electerious.com")!,
    // requires an actual host url!
    appUrl: URL(string: "yourapp://some.domain")!,
    disabled: false
  )
)

// record your controllers
ackee.record("MyViewController")
// or deep links
ackee.record("deep/linking/url")
```

> **Note:** As of now, recording advanced attributes isn't possible yet, but may follow in future.

## License

AckeeTracker is available under the [MIT](./LICENSE) license.
