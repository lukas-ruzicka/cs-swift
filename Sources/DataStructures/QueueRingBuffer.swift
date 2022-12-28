/// FIFO, first-in first-out
public struct QueueRingBuffer<T>: Queue {

    private var ringBuffer: RingBuffer<T>

    /// - Parameter count: Fixed size capacity
    public init(count: Int) {
        ringBuffer = RingBuffer<T>(count: count)
    }

    /// O(1) time complexity
    public var isEmpty: Bool {
        ringBuffer.isEmpty
    }

    /// O(1) time complexity
    public var peek: T? {
        ringBuffer.first
    }

    /// O(1) time complexity
    /// - Returns: `false` if you've reached the fixed size capacity
    public mutating func enqueue(_ element: T) -> Bool {
        ringBuffer.write(element)
    }

    /// O(1) time complexity
    public mutating func dequeue() -> T? {
        isEmpty ? nil : ringBuffer.read()
    }
}

extension QueueRingBuffer: CustomStringConvertible {

    public var description: String {
        String(describing: ringBuffer)
    }
}
