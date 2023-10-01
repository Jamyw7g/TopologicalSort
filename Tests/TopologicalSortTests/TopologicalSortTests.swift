import XCTest
@testable import TopologicalSort

final class TopologicalSortTests: XCTestCase {
    func testFunctionality() throws {
        var top = TopologicalSort<String>()
        top.add(predecessor: "a", successor: "b")
        top.add(predecessor: "a", successor: "d")
        top.add(predecessor: "b", successor: "c")
        
        [["a"], ["b", "d"], ["c"]].forEach { inner in
            let ori = Set(inner)
            let res = Set(top.popAll())
            XCTAssert(ori.union(res) == res)
        }
        XCTAssert(top.count == 0)
    }
    
    func testCycle() throws {
        var top = TopologicalSort<String>()
        top.add(predecessor: "a", successor: "b")
        top.add(predecessor: "b", successor: "a")
        
        let data = top.popAll()
        XCTAssert(data.isEmpty && !top.isEmpty)
    }
}
