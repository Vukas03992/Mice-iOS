import XCTest
@testable import Mice

final class MiceTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Mice().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
