/// FIFO, first-in first-out
public struct QueueArray<T>: Queue {

    private var array: [T] = []
    public init() {}

    /// O(1) time complexity
    public var isEmpty: Bool {
        array.isEmpty
    }

    /// O(1) time complexity
    public var peek: T? {
        array.first
    }

    /// O(1) time complexity
    @discardableResult
    public mutating func enqueue(_ element: T) -> Bool {
        array.append(element)
        return true
    }

    /// O(n) time complexity
    public mutating func dequeue() -> T? {
        isEmpty ? nil : array.removeFirst()
    }
}

extension QueueArray: CustomStringConvertible {

    public var description: String {
        String(describing: array)
    }
}
