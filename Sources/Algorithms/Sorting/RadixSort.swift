import Foundation

extension Array where Element == Int {

    /// non-comparative
    /// sorts by bucketing digits from back (least significant digit)
    /// O(k \* n) time complexity, where k is the number of significant digits of the largest number
    /// O(n) space complexity
    public mutating func radixSort() {
        let base = 10
        var done = false
        var digits = 1
        while !done {
            done = true
            var buckets: [[Int]] = .init(repeating: [], count: base)
            forEach { number in
                let remainingPart = number / digits
                if remainingPart > 0 {
                    done = false
                }
                let digit = remainingPart % base
                buckets[digit].append(number)
            }
            digits *= base
            self = buckets.flatMap { $0 }
        }
    }

    /// non-comparative
    /// sorts by bucketing digits from front (most significant digit)
    public mutating func lexicographicalSort() {
        self = msdRadixSorted(self)
    }

    private func msdRadixSorted(_ array: [Int], _ position: Int = 0) -> [Int] {
        guard position < array.maxDigits else { return array }
        var buckets: [[Int]] = .init(repeating: [], count: 10)
        var priorityBucket: [Int] = []

        array.forEach { number in
            guard let digit = number.digit(atPosition: position) else {
                priorityBucket.append(number)
                return
            }
            buckets[digit].append(number)
        }

        priorityBucket.append(contentsOf: buckets.reduce(into: []) { result, bucket in
            guard !bucket.isEmpty else {
                return
            }
            result.append(contentsOf: msdRadixSorted(bucket, position + 1))
        })

        return priorityBucket
    }

    private var maxDigits: Int {
        self.max()?.digits ?? 0
    }
}

extension Int {

    var digits: Int {
        var count = 0
        var num = self
        while num != 0 {
            count += 1
            num /= 10
        }
        return count
    }

    func digit(atPosition position: Int) -> Int? {
        guard position < digits else {
            return nil
        }
        var num = self
        let correctedPosition = Double(position + 1)
        while num / Int(pow(10, correctedPosition)) != 0 {
            num /= 10
        }
        return num % 10
    }
}

extension Array where Element == String {

    /// non-comparative
    /// sorts by bucketing characters from front (most significant digit)
    public mutating func lexicographicalSort() {
        self = msdRadixSorted(self)
    }

    private func msdRadixSorted(_ array: [String], _ position: Int = 0) -> [String] {
        guard position < array.maxLength else { return array }
        let asciiOffset = 97
        let charCount = 26
        var buckets: [[String]] = .init(repeating: [], count: charCount)
        var priorityBucket: [String] = []

        array.forEach { string in
            guard let char = string[safe: position],
                    let charAsciiValue = Character(char.lowercased()).asciiValue,
                    Int(charAsciiValue) - asciiOffset < charCount else {
                priorityBucket.append(string)
                return
            }
            print(char)
            buckets[Int(charAsciiValue) - asciiOffset].append(string)
        }

        priorityBucket.append(contentsOf: buckets.reduce(into: []) { result, bucket in
            guard !bucket.isEmpty else {
                return
            }
            result.append(contentsOf: msdRadixSorted(bucket, position + 1))
        })

        return priorityBucket
    }

    private var alphabet: String { "abcdefghijklmnopqrstuvwxyz" }

    private var maxLength: Int {
        map { $0.count }.max() ?? 0
    }
}

private extension String {

    subscript(safe safe: Int) -> Character? {
        guard safe >= 0 && safe < count else {
            return nil
        }
        return self[index(startIndex, offsetBy: safe)] as Element
    }
}
