import DataStructures

extension Graph where Element: Hashable {

    /// explores all the current vertex’s neighbors before traversing the next level of vertices
    /// O(V + E) time complexity, where `V` is for vertices and `E` is for edges
    /// O(V) space complexity
    func breadthFirstSearch(from source: Vertex<Element>) -> [Vertex<Element>] {
        var queue = QueueStack<Vertex<Element>>()
        var enqueued: Set<Vertex<Element>> = []
        var visited: [Vertex<Element>] = []

        queue.enqueue(source)
        enqueued.insert(source)

        while let vertex = queue.dequeue() {
            visited.append(vertex)
            let neighborEdges = edges(from: vertex)
            for edge in neighborEdges where !enqueued.contains(edge.destination) {
                queue.enqueue(edge.destination)
                enqueued.insert(edge.destination)
            }
        }

        return visited
    }
}
