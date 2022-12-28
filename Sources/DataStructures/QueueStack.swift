/// FIFO, first-in first-out
public struct QueueStack<T> : Queue {

    private var leftStack: [T] = []
    private var rightStack: [T] = []
    public init() {}

    /// O(1) time complexity
    public var isEmpty: Bool {
        leftStack.isEmpty && rightStack.isEmpty
    }

    /// O(1) time complexity
    public var peek: T? {
        !leftStack.isEmpty ? leftStack.last : rightStack.first
    }

    /// O(1) time complexity
    @discardableResult
    public mutating func enqueue(_ element: T) -> Bool {
        rightStack.append(element)
        return true
    }

    /// O(1) time complexity, but O(n) in case the stack needs to be reversed (accessing element that has been added since the last dequeue)
    public mutating func dequeue() -> T? {
        if leftStack.isEmpty {
            leftStack = rightStack.reversed()
            rightStack.removeAll()
        }
        return leftStack.popLast()
    }
}

extension QueueStack: CustomStringConvertible {

    public var description: String {
        let printList = leftStack.reversed() + rightStack
        return String(describing: printList)
    }
}
