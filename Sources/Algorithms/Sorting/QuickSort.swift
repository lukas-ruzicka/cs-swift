
// MARK: - Lomuto

public func quicksortLomuto<T: Comparable>(_ array: inout [T], low: Int = 0, high: Int? = nil) {
    let high = high ?? array.count - 1
    if low < high {
        let pivot = partitionLomuto(&array, low: low, high: high)
        quicksortLomuto(&array, low: low, high: pivot - 1)
        quicksortLomuto(&array, low: pivot + 1, high: high)
    }
}

private func partitionLomuto<T: Comparable>(_ array: inout [T], low: Int, high: Int) -> Int {
    let pivot = array[high]
    var i = low
    for j in low..<high {
        if array[j] <= pivot {
            array.swapAt(i, j)
            i += 1
        }
    }
    array.swapAt(i, high)
    return i
}

// MARK: - Hoare

/// first element as pivot
/// O(n log n) average time complexity, but O(nˆ2) at worst
public func quicksortHoare<T: Comparable>(_ array: inout [T], low: Int = 0, high: Int? = nil) {
    let high = high ?? array.count - 1
    if low < high {
        let p = partitionHoare(&array, low: low, high: high)
        quicksortHoare(&array, low: low, high: p)
        quicksortHoare(&array, low: p + 1, high: high)
    }
}

private func partitionHoare<T: Comparable>(_ array: inout [T], low: Int, high: Int) -> Int {
    let pivot = array[low]
    var i = low - 1
    var j = high + 1

    while true {
        repeat { j -= 1 } while array[j] > pivot
        repeat { i += 1 } while array[i] < pivot

        if i < j {
            array.swapAt(i, j)
        } else {
            return j
        }
    }
}

// MARK: - Median of three

/// pivot by taking the median of the first, middle and last element -> then using Lomuto
/// O(n log n) average time complexity, but O(nˆ2) at worst
public func quickSortMedian<T: Comparable>(_ array: inout [T], low: Int = 0, high: Int? = nil) {
    let high = high ?? array.count - 1
    if low < high {
        let pivotIndex = medianOfThree(&array, low: low, high: high)
        array.swapAt(pivotIndex, high)
        let pivot = partitionLomuto(&array, low: low, high: high)
        quicksortLomuto(&array, low: low, high: pivot - 1)
        quicksortLomuto(&array, low: pivot + 1, high: high)
    }
}

private func medianOfThree<T: Comparable>(_ array: inout [T], low: Int, high: Int) -> Int {
    let center = (low + high) / 2
    if array[low] > array[center] {
        array.swapAt(low, center)
    }
    if array[low] > array[high] {
        array.swapAt(low, high)
    }
    if array[center] > array[high] {
        array.swapAt(center, high)
    }
    return center
}

// MARK: - Dutch flag

/// in case we have a lot of duplicates
/// O(n log n) average time complexity, but O(nˆ2) at worst
public func quicksortDutchFlag<T: Comparable>(_ array: inout [T], low: Int = 0, high: Int? = nil) {
    let high = high ?? array.count - 1
    if low < high {
        let (middleFirst, middleLast) = partitionDutchFlag(&array, low: low, high: high, pivotIndex: high)
        quicksortDutchFlag(&array, low: low, high: middleFirst - 1)
        quicksortDutchFlag(&array, low: middleLast + 1, high: high)
    }
}

private func partitionDutchFlag<T: Comparable>(_ array: inout [T], low: Int, high: Int, pivotIndex: Int) -> (Int, Int) {
    let pivot = array[pivotIndex]
    var smaller = low
    var equal = low
    var larger = high
    while equal <= larger {
        if array[equal] < pivot {
            array.swapAt(smaller, equal)
            smaller += 1
            equal += 1
        } else if array[equal] == pivot {
            equal += 1
        } else {
            array.swapAt(equal, larger)
            larger -= 1
        }
    }
    return (smaller, larger)
}
