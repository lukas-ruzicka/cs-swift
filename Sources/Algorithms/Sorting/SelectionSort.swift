/// finds lowest value and swaps at the end of iteration (reduces calls of `swapAt`) - has always n-1 iterations
/// O(nˆ2) time complexity
/// O(1) space complexity  
public func selectionSort<T>(_ collection: inout T) where T: MutableCollection, T.Element: Comparable {
    guard collection.count >= 2 else {
        return
    }
    for current in collection.indices {
        var lowest = current
        var other = collection.index(after: current)
        while other < collection.endIndex {
            if collection[lowest] > collection[other] {
                lowest = other
            }
            other = collection.index(after: other)
        }
        if lowest != current {
            collection.swapAt(lowest, current)
        }
    }
}
