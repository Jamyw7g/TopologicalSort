// The Swift Programming Language
// https://docs.swift.org/swift-book

public struct TopologicalSort<Element: Hashable> {
    private var container = [Element:Correlation]()
    
    public mutating func add(predecessor pred: Element, successor succ: Element) {
        let (inserted, _) = container[pred, default: Correlation()].successors.insert(succ)
        // The successor is exists.
        if !inserted {
            return
        }
        container[succ, default: Correlation()].predecessorNum += 1
    }
    
    public func peek() -> Element? {
        container.lazy
            .filter { $1.predecessorNum == 0 }
            .map { (key, _) in
                key
            }
            .first
    }
    
    public mutating func pop() -> Element? {
        guard let ele = peek() else {
            return nil
        }
        remove(ele)
        return ele
    }
    
    public func peekAll() -> [Element] {
        container.lazy
            .filter { $1.predecessorNum == 0}
            .map { (key, _) in
                key
            }
    }
    
    public mutating func popAll() -> [Element] {
        let canPopData = peekAll()
        canPopData.forEach { remove($0) }
        return canPopData
    }
    
    public var count: Int {
        container.count
    }
    
    @inlinable public var isEmpty: Bool {
        count == 0
    }
}

private extension TopologicalSort {
    mutating func remove(_ ele: Element) {
        if let correlation = container.removeValue(forKey: ele) {
            correlation.successors
                .forEach { succ in
                    container[succ]?.predecessorNum -= 1
                }
        }
    }
}


private extension TopologicalSort {
    struct Correlation {
        var predecessorNum = 0
        var successors = Set<Element>()
    }
}
