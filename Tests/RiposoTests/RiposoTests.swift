import XCTest
@testable import Riposo

final class RiposoTests: XCTestCase {
    func test() {
        XCTAssertEqual("test", "test")
    }

    static var allTests = [
        ("test", test),
    ]
}
