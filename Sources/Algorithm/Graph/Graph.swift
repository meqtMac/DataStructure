//
//  File.swift
//  
//
//  Created by 蒋艺 on 2023/8/31.
//

import Foundation
public protocol GraphProtocol {
    typealias Vertice = Int
    init(vertices: Int)
    /// init from input stream
    mutating func addEdge(from left: Vertice, to right: Vertice)
    func adjacent(to vertice: Vertice) -> [Vertice]
    var verticeCount: Int { get }
    var edgeCount: Int { get}
    
    func degree(of vertice: Vertice) -> Int
    func maxDegree() -> Int
    func averageDegree() -> Double
    func numberOfSelfLoops() -> Int
}

extension GraphProtocol {
    public func degree(of vertice: Vertice) -> Int {
        adjacent(to: vertice).count
    }
    public func maxDegree() -> Int {
        (0..<verticeCount)
            .map { degree(of: $0) }
            .max() ?? 0
    }
    public func averageDegree() -> Double {
        (0..<verticeCount)
            .map { degree(of: $0) }
            .reduce(0) { $0 + Double($1) }  / Double(verticeCount)
    }
    
    public func numberOfSelfLoops() -> Int {
        (0..<verticeCount)
            .filter { adjacent(to: $0).contains($0) }
            .count / 2
    }
}

public struct Graph: GraphProtocol {
    public func adjacent(to vertice: Vertice) -> [Vertice] {
        adjacencyList[vertice]
    }
    
    public typealias AdjecentVertices = [Vertice]
    public let verticeCount: Int
    public var edgeCount: Int {
        adjacencyList.reduce(0) { partialResult, vertices in
            partialResult +  vertices.count
        }
    }
    private var adjacencyList: [AdjecentVertices]
    
    public init(vertices: Int) {
        verticeCount = vertices
        adjacencyList = .init(repeating: [], count: vertices)
    }
    
    public mutating func addEdge(from v: Vertice, to w: Vertice) {
        adjacencyList[v].append(w)
    }
}



/// Adjacency-matrix graph representation
/// Adjacency-list graph representation

/**
 Depth-first search
 Decouple graph data type from graph processing
 - Create a Graph object
 - Pass the Graph to a graph-processing routine
 - Query the graph-processing routine for information
 */
public class DepthFirstPaths {
    private var marked: [Bool]
    private var edgeTo: [Int]
    private let s: Int
    
    public init(graph: GraphProtocol, s: Int) {
        fatalError()
        /// initial data structures
    }
    
    private func dfs(graph: GraphProtocol, v: Int) {
        marked[v] = true
        for w in graph.adjacent(to: v) {
            if !marked[v] {
                dfs(graph: graph, v: w)
                edgeTo[w] = v
            }
        }
    }
    
    public func hasPathTo(v: Int) -> Bool {
        return marked[v]
    }
    
    public func pathTo(v: Int) -> [Int] {
        if (!hasPathTo(v: v)) {
            return []
        }
        
        var pathStack: [Int] = []
        var x = v
        while (x != s) {
            pathStack.append(x)
            x = edgeTo[x]
        }
        pathStack.append(s)
        return pathStack
            
    }
}


/// Preprocess graph to answer queries of the form is `v` connected to `w`? in **constant** time.
/// The relation `is connected to` is an equivalence relation
/// - Reflexive
/// - Symmertic
/// - Transitive
/// Def: A connected component is a maximal set of connected vertices
/// Goal: Partition vertices into connected components
protocol Connectivity {
    associatedtype Element
    /// are lhs and rhs connected
    func isConnected(lhs: Element, rhs: Element) -> Bool
    /// number of connected components
    func counted() -> Int
//    / component identifier for v
//    func id(of v: Element) -> Int
    var id: [Int] { get }
}

extension Connectivity where Element == Int{
    func isConnected(lhs: Element, rhs: Element) -> Bool {
        id[lhs] == id[rhs]
    }
}

/**
 - To Mark vertex `v` as visited, Recursively visit all unmarked vertices adjacent to `v`.
 - Recursively visit all unmarked vertices adjacent to v.
 */
public struct ConnectedComponent: Connectivity {
    typealias Element = Int
    
    func counted() -> Int {
        self.connectedCount
    }
    
    let id: [Int]
    let connectedCount: Int
    
    public init(with graph: some GraphProtocol) {
       (self.id, self.connectedCount) = Self.dfs(on: graph)
    }
    
    private static func dfs(on graph: some GraphProtocol) -> ([Int], Int) {
        var marked = [Bool](repeating: false, count: graph.verticeCount)
        var id = (0..<graph.verticeCount).map { $0 }
        var connectedCount = 0
        
        func dfsHelper(from vertice: Int) {
            marked[vertice] = true
            id[vertice] = connectedCount
            for connectedVertice in graph.adjacent(to: vertice) {
                if !marked[connectedVertice] {
                    dfsHelper(from: connectedVertice)
                }
            }
        }
        
        for i in 0..<graph.verticeCount {
            if (!marked[i]) {
                dfsHelper(from: i)
                connectedCount += 1
            }
        }
        
        return (id, connectedCount)
    }
}

/**
 Graph-processing challenges
 - 1: bipartite
 - 2: Find a cycle
 - 3: Bridges of Könighsberg: Find a (general) cycle that uses every **edge** exactly once.
 - 4: Find a cycle that visits every **vertex** exactly once.
     - Intractable: Hamiltonian cycle (classical NP-complete problem)
 - 5: Are two graphs identical except for vertex name?
 - 6: Lay out a graph in the plane without crossing edges?
    linear-Time DFS-based planarit algorithm discovered by Tarjan in 1970s.
 */
