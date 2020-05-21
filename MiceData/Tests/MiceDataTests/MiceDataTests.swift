import XCTest
@testable import MiceData

final class MiceDataTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(MiceData().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
