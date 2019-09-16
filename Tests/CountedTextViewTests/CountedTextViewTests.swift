import XCTest
@testable import CountedTextView

final class CountedTextViewTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(CountedTextView().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
