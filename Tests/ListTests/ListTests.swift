import XCTest
@testable import List

class ListTests: XCTestCase {
    func testBenchmark() {
		measure {
			let li = List<Int>()
			for i in 0..<500000 {
				li.append(i)
			}
		}
    }


    static var allTests = [
        ("testBenchmark", testBenchmark),
    ]
}
