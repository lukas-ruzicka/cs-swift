/// binary tree represented in an array (read level by level as rows)
/// efficient time and space complexity, as the elements in a heap are all stored together in memory
public struct Heap<Element: Equatable> {

    var elements: [Element] = []
    let sort: (Element, Element) -> Bool

    public init(sort: @escaping (Element, Element) -> Bool, elements: [Element] = []) {
        self.sort = sort
        self.elements = elements
        buildHeap()
    }

    /// O(n) time complexity
    mutating public func merge(heap: Heap) {
        elements += heap.elements
        buildHeap()
    }

    /// O(1) time complexity
    public func copy() -> Heap<Element> {
        var copy = Heap(sort: sort)
        copy.elements = elements
        return copy
    }

    /// O(1) time complexity
    public var isEmpty: Bool {
        elements.isEmpty
    }

    /// O(1) time complexity
    public var count: Int {
        elements.count
    }

    /// O(1) time complexity
    public func peek() -> Element? {
        elements.first
    }

    /// O(n) time complexity
    mutating public func buildHeap() {
        if !elements.isEmpty {
            for i in stride(from: elements.count / 2 - 1, through: 0, by: -1) {
                siftDown(from: i)
            }
        }
    }

    /// O(1) time complexity
    func leftChildIndex(ofParentAt index: Int) -> Int {
        (2 * index) + 1
    }

    /// O(1) time complexity
    func rightChildIndex(ofParentAt index: Int) -> Int {
        (2 * index) + 2
    }

    /// O(1) time complexity
    public func parentIndex(ofChildAt index: Int) -> Int {
        (index - 1) / 2
    }

    /// O(log n) time complexity
    public mutating func remove() -> Element? {
        guard !isEmpty else {
            return nil
        }
        elements.swapAt(0, count - 1)
        defer {
            siftDown(from: 0)
        }
        return elements.removeLast()
    }

    /// O(log n) time complexity
    mutating func siftDown(from index: Int, upTo size: Int? = nil) {
        var parent = index
        while true {
            let left = leftChildIndex(ofParentAt: parent)
            let right = rightChildIndex(ofParentAt: parent)
            var candidate = parent
            if left < size ?? count && sort(elements[left], elements[candidate]) {
                candidate = left
            }
            if right < size ?? count && sort(elements[right], elements[candidate]) {
                candidate = right
            }
            if candidate == parent {
                return
            }
            elements.swapAt(parent, candidate)
            parent = candidate
        }
    }

    /// O(log n) time complexity
    public mutating func insert(_ element: Element) {
        elements.append(element)
        siftUp(from: elements.count - 1)
    }

    /// O(log n) time complexity
    mutating func siftUp(from index: Int) {
        var child = index
        var parent = parentIndex(ofChildAt: child)
        while child > 0 && sort(elements[child], elements[parent]) {
            elements.swapAt(child, parent)
            child = parent
            parent = parentIndex(ofChildAt: child)
        }
    }

    /// O(log n) time complexity
    public mutating func remove(at index: Int) -> Element? {
        guard index < elements.count else {
            return nil
        }
        if index == elements.count - 1 {
            return elements.removeLast()
        } else {
            elements.swapAt(index, elements.count - 1)
            defer {
                siftDown(from: index)
                siftUp(from: index)
            }
            return elements.removeLast()
        }
    }

    /// O(n) time complexity
    func index(of element: Element, startingAt i: Int = 0) -> Int? {
        if i >= count {
            return nil
        }
        if sort(element, elements[i]) {
            return nil
        }
        if element == elements[i] {
            return i
        }
        if let j = index(of: element, startingAt: leftChildIndex(ofParentAt: i)) {
            return j
        }
        if let j = index(of: element, startingAt: rightChildIndex(ofParentAt: i)) {
            return j
        }
        return nil
    }
}

// MARK: - Sort
extension Heap {

    /// Ascending for max heap, descending for min heap.
    ///
    /// O(n log n) time complexity
    /// O(n) space complexity
    func sorted() -> [Element] {
        var heap = copy()
        for index in heap.elements.indices.reversed() {
            heap.elements.swapAt(0, index)
            heap.siftDown(from: 0, upTo: index)
        }
        return heap.elements
    }
}
