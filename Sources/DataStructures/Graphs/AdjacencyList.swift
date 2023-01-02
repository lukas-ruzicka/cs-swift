/// suited for sparse graph (few edges)
/// O(V + E) space complexity, where `V` is for vertices and `E` is for edges
public class AdjacencyList<T: Hashable>: Graph {

    private var adjacencies: [Vertex<T>: [Edge<T>]] = [:]

    public init() {}

    public var allVertices: [Vertex<T>] {
        Array(adjacencies.keys)
    }

    /// O(1) time complexity
    public func createVertex(data: T) -> Vertex<T> {
        let vertex = Vertex(index: adjacencies.count, data: data)
        adjacencies[vertex] = []
        return vertex
    }

    /// O(1) time complexity
    public func addDirectedEdge(from source: Vertex<T>, to destination: Vertex<T>, weight: Double?) {
        let edge = Edge(source: source, destination: destination, weight: weight)
        adjacencies[source]?.append(edge)
    }

    /// O(1) time complexity
    public func edges(from source: Vertex<T>) -> [Edge<T>] {
        adjacencies[source] ?? []
    }

    /// O(n) time complexity
    public func weight(from source: Vertex<T>, to destination: Vertex<T>) -> Double? {
        edges(from: source).first { $0.destination == destination }?.weight
    }

    /// O(n) time complexity
    public func copyVertices(from graph: AdjacencyList) {
        for vertex in graph.allVertices {
            adjacencies[vertex] = []
        }
    }
}

extension AdjacencyList: CustomStringConvertible {

    public var description: String {
        var result = ""
        for (vertex, edges) in adjacencies {
            var edgeString = ""
            for (index, edge) in edges.enumerated() {
                if index != edges.count - 1 {
                    edgeString.append("\(edge.destination), ")
                } else {
                    edgeString.append("\(edge.destination)")
                }
            }
            result.append("\(vertex) ---> [ \(edgeString) ]\n")
        }
        return result
    }
}
