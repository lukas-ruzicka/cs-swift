import DataStructures

public class Prim<T: Hashable> {

    public typealias Graph = AdjacencyList<T>

    public init() {}

    /// produces tree (= all vertices connected and without loops) with minumum sum of weights
    /// O(E log E) time complexity, where `E` is for edges
    public func produceMinimumSpanningTree(for graph: Graph) -> (cost: Double, mst: Graph) {
        var cost = 0.0
        let mst = Graph()
        var visited = Set<Vertex<T>>()
        var priorityQueue = PriorityQueue<Edge<T>>() {
            $0.weight ?? 0 < $1.weight ?? 0
        }

        mst.copyVertices(from: graph)
        guard let start = graph.allVertices.first else { return (cost: cost, mst: mst) }

        visited.insert(start)
        addAvailableEdges(for: start, in: graph, check: visited, to: &priorityQueue)

        while let cheapestEdge = priorityQueue.dequeue() {
            let vertex = cheapestEdge.destination
            guard !visited.contains(vertex) else { continue }

            visited.insert(vertex)
            cost += cheapestEdge.weight ?? 0

            mst.add(.undirected, from: cheapestEdge.source, to: cheapestEdge.destination, weight: cheapestEdge.weight)

            addAvailableEdges(for: vertex, in: graph, check: visited, to: &priorityQueue)
        }

        return (cost: cost, mst: mst)
    }
}

private extension Prim {

    func addAvailableEdges(for vertex: Vertex<T>, in graph: Graph,
                           check visited: Set<Vertex<T>>,
                           to priorityQueue: inout PriorityQueue<Edge<T>>) {
        for edge in graph.edges(from: vertex) where !visited.contains(edge.destination) {
            priorityQueue.enqueue(edge)
        }
    }
}
