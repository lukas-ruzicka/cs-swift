/// swapping lower value back until it reaches lower value - max n-1 iterations needed
/// best sort if you know that the data is mostly sorted
/// O(nˆ2) average & worst time complexity, Ω(n) time complexity if the array is already sorted
/// O(1) space complexity  
public func insertionSort<T>(_ collection: inout T) where T: BidirectionalCollection & MutableCollection, T.Element: Comparable {
    guard collection.count >= 2 else {
        return
    }
    for current in collection.indices {
        var shifting = current
        while shifting > collection.startIndex {
            let previous = collection.index(before: shifting)
            if collection[shifting] < collection[previous] {
                collection.swapAt(shifting, previous)
            } else {
                break
            }
            shifting = previous
        }
    }
}
