/// FIFO, first-in first-out
public class QueueLinkedList<T>: Queue {

    private var list = DoublyLinkedList<T>()
    public init() {}

    /// O(1) time complexity, but an expensive dynamic allocation
    @discardableResult
    public func enqueue(_ element: T) -> Bool {
        list.append(element)
        return true
    }

    /// O(1) time complexity
    public func dequeue() -> T? {
        guard !list.isEmpty, let element = list.first else {
            return nil
        }
        return list.remove(element)
    }

    /// O(1) time complexity
    public var peek: T? {
        list.first?.value
    }

    /// O(1) time complexity
    public var isEmpty: Bool {
        list.isEmpty
    }
}

extension QueueLinkedList: CustomStringConvertible {
    
    public var description: String {
        String(describing: list)
    }
}
