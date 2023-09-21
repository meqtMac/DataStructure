//
//  File.swift
//  
//
//  Created by 蒋艺 on 2023/9/17.
//

struct Edge {
    let v: Int
    let w: Int
    let weight: Double
    
    public init(v: Int, w: Int, weigth: Double) {
        self.v = v
        self.w = w
        self.weight = weigth
    }
}

extension Edge: Comparable {
    static func < (lhs: Edge, rhs: Edge) -> Bool {
        return lhs.weight < rhs.weight
    }
}
protocol EWG {
    mutating func add(edge: Edge)
    associatedtype Edges: Sequence<Edge>
    func adjacent(to v: Int) -> Edges
}



struct EdgeWeightedGraph {
    private let vertices: Int
    private var adj: [ [Edge] ]
    
    public init(vertices: Int) {
        self.vertices = vertices
        self.adj = [[Edge]](repeating: [], count: vertices)
    }
    
    mutating func add(edge: Edge) {
        adj[edge.v].append(edge)
        adj[edge.w].append(edge)
    }
    
    func adjacent(to v: Int) -> [Edge] {
        adj[v]
    }
}

protocol MSTProtocol {
    init(graph: EdgeWeightedGraph)
    var edges: [Edge] { get }
}
//struct MST {
//    private let edges: [Edge]
//    init(graph: EdgeWeightedGraph) {
//        // TODO: init
//        fatalError()
//    }
//}
