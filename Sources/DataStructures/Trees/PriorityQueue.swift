/// sorted queue - uses heap under the hood in order to achieve `O(log n)` complexity
public struct PriorityQueue<Element: Equatable>: Queue {

    private var heap: Heap<Element>

    public init(sort: @escaping (Element, Element) -> Bool, elements: [Element] = []) {
        heap = Heap(sort: sort, elements: elements)
    }

    /// O(1) time complexity
    public var isEmpty: Bool {
        heap.isEmpty
    }

    /// O(1) time complexity
    public var peek: Element? {
        heap.peek()
    }

    /// O(log n) time complexity
    @discardableResult
    public mutating func enqueue(_ element: Element) -> Bool {
        heap.insert(element)
        return true
    }

    /// O(log n) time complexity
    public mutating func dequeue() -> Element? {
        heap.remove()
    }
}
