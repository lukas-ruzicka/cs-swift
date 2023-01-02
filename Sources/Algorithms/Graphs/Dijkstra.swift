import DataStructures

public class Dijkstra<T: Hashable> {

    public enum Visit<T: Hashable> {

        case start
        case edge(Edge<T>)
    }

    public typealias Graph = AdjacencyList<T>
    let graph: Graph

    public init(graph: Graph) {
        self.graph = graph
    }

    /// finds shortest paths to each vertex by given edge weights
    /// O(E log V) time complexity, where `V` is for vertices and `E` is for edges
    public func shortestPath(from start: Vertex<T>) -> [Vertex<T>: Visit<T>] {
        var paths: [Vertex<T>: Visit<T>] = [start: .start]

        var priorityQueue = PriorityQueue<Vertex<T>>() {
            self.distance(to: $0, with: paths) < self.distance(to: $1, with: paths)
        }
        priorityQueue.enqueue(start)

        while let vertex = priorityQueue.dequeue() {
            for edge in graph.edges(from: vertex) {
                guard let weight = edge.weight else { continue }
                if paths[edge.destination] == nil ||
                    distance(to: vertex, with: paths) + weight < distance(to: edge.destination, with: paths) {
                    paths[edge.destination] = .edge(edge)
                    priorityQueue.enqueue(edge.destination)
                }
            }
        }

        return paths
    }

    public func shortestPath(to destination: Vertex<T>, paths: [Vertex<T>: Visit<T>]) -> [Edge<T>] {
        route(to: destination, with: paths)
    }
}

private extension Dijkstra {

    func distance(to destination: Vertex<T>, with paths: [Vertex<T>: Visit<T>]) -> Double {
        let path = route(to: destination, with: paths)
        return path.compactMap(\.weight).reduce(0, +)
    }

    func route(to destination: Vertex<T>, with paths: [Vertex<T>: Visit<T>]) -> [Edge<T>] {
        var vertex = destination
        var path: [Edge<T>] = []

        while let visit = paths[vertex], case .edge(let edge) = visit {
            path.append(edge)
            vertex = edge.source
        }
        return path.reversed()
    }
}
