/// compares by each index and swaps (highest values will “bubble up” to the end) - max n-1 iterations needed
/// O(nˆ2) average & worst time complexity, Ω(n) time complexity if the array is already sorted
/// O(1) space complexity 
public func bubbleSort<T>(_ collection: inout T) where T: MutableCollection, T.Element: Comparable {
    guard collection.count >= 2 else {
        return
    }
    for end in collection.indices.reversed() {
        var swapped = false
        var current = collection.startIndex
        while current < end {
            let next = collection.index(after: current)
            if collection[current] > collection[next] {
                collection.swapAt(current, next)
                swapped = true
            }
            current = next
        }
        if !swapped {
            return
        }
    }
}
