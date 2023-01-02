import DataStructures

extension Graph where Element: Hashable {

    /// explores a branch as far as possible until it reaches the end
    /// O(V + E) time complexity, where `V` is for vertices and `E` is for edges
    /// O(V) space complexity
    func depthFirstSearch(from source: Vertex<Element>) -> [Vertex<Element>] {
        var pushed: Set<Vertex<Element>> = []
        var visited: [Vertex<Element>] = []

        depthFirstSearch(from: source, visited: &visited, pushed: &pushed)

        return visited
    }

    private func depthFirstSearch(from source: Vertex<Element>,
                                  visited: inout [Vertex<Element>],
                                  pushed: inout Set<Vertex<Element>>) {
        pushed.insert(source)
        visited.append(source)

        let neighbors = edges(from: source)
        for edge in neighbors {
            if !pushed.contains(edge.destination) {
                depthFirstSearch(from: edge.destination,
                                 visited: &visited,
                                 pushed: &pushed)
            }
        }
    }
}

