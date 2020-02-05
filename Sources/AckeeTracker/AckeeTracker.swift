import Foundation

/// The Ackee Tracker to be used across your app.
/// Prefer using this protocol instead of the concrete `AckeeTracker` implementation.
public protocol Tracker {
  /// Creates a new record on the server and updates the record constantly to track the duration of the visit.
  /// The update of old records will be canceled when you call this function once again.
  ///
  /// Typically names of your `ViewController`s will be provided here.
  /// Alternatively you could provide deep linking URLs to directly access contents from within your Ackee instance.
  ///
  /// ```
  /// ackee.record("MyController")
  /// ackee.record("deep/linking/url")
  /// ```
  ///
  /// - Parameters:
  ///     - location: The current site that should be reported.
  func record(_ location: String)
}

/// The production Ackee Tracker implementation.
/// Note that you need to provide an actual domain.
/// Just proividing an app scheme is not sufficient.
/// ```
/// let ackee: Tracker = AckeeTracker(
///     configuration: AckeeConfiguration(
///         domainId: "<your-domain-id>",
///         serverUrl: URL(string: "https://ackee.electerious.com")!,
///         // requires an actual host url!
///         appUrl: URL(string: "yourapp://some.domain")!
///     )
/// )
/// ```
public final class AckeeTracker: Tracker {
  private let configuration: AckeeConfiguration
  private let dependencies: AckeeDependencies
  private let server: AckeeServer

  /// Creates an Ackee Tracker for production.
  ///
  /// - Parameters:
  ///     - configuration: The configuration of URLs and domain ids.
  ///     - dependencies: When required, you can override internally used mechanisms.
  public init(
    configuration: AckeeConfiguration,
    dependencies: AckeeDependencies = .prod()
  ) {
    self.configuration = configuration
    self.dependencies = dependencies
    self.server = AckeeServer(configuration: configuration, dependencies: dependencies)
  }

  public func record(_ location: String) {
    server.post(
      attributes: Attributes(
        siteLocation: configuration.appUrl.appendingPathComponent(location).absoluteString)
    ) { _ in }
  }
}
