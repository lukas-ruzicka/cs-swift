/// LIFO, last-in first-out
public struct Stack<Element> {

    private var storage: [Element] = []

    public init() { }

    public init(_ elements: [Element]) {
        storage = elements
    }

    /// O(1) time complexity
    public mutating func push(_ element: Element) {
        storage.append(element)
    }

    /// O(1) time complexity
    @discardableResult
    public mutating func pop() -> Element? {
        storage.popLast()
    }

    /// O(1) time complexity
    public func peek() -> Element? {
        storage.last
    }

    /// O(1) time complexity
    public var isEmpty: Bool {
        peek() == nil
    }
}

extension Stack: CustomDebugStringConvertible {

    public var debugDescription: String {
    """
    ----top----
    \(storage.map { "\($0)" }.reversed().joined(separator: "\n"))
    -----------
    """
    }
}

extension Stack: ExpressibleByArrayLiteral {

    public init(arrayLiteral elements: Element...) {
        storage = elements
    }
}
