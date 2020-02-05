import XCTest

@testable import AckeeTracker

final class AckeeTrackerTests: XCTestCase {
  var ackee: Tracker! = nil
  var errors: [Error]! = nil

  var fetchInvocation: (request: URLRequest, receive: (Data?, URLResponse?, Error?) -> Void)?

  override func setUp() {
    errors = []
    ackee = AckeeTracker(
      configuration: AckeeConfiguration(
        domainId: "4b000a4c-b803-4c0f-ae75-0f719af4881b",
        serverUrl: URL(string: "https://ack.knabel.dev")!,
        appUrl: URL(string: "com.company.MyApp")!
      ),
      dependencies: AckeeDependencies(
        report: { self.errors.append($0) },
        fetch: { self.fetchInvocation = ($0, $1) }
      )
    )
  }

  override func tearDown() {
    fetchInvocation = nil
  }

  func testPerformsRequest() {
    ackee.record("MyController")

    XCTAssertEqual(errors.count, 0)
    XCTAssertNotNil(fetchInvocation)
    XCTAssertEqual(
      fetchInvocation?.request.url?.absoluteString,
      "https://ack.knabel.dev/domains/4b000a4c-b803-4c0f-ae75-0f719af4881b/records"
    )
    XCTAssertEqual(
      try fetchInvocation?.request.httpBody.map {
        try AckeeDependencies.apiDecoder.decode(Attributes.self, from: $0)
      },
      Attributes(siteLocation: "com.company.MyApp/MyController")
    )
  }
}
