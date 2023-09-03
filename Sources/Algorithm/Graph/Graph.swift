//
//  File.swift
//  
//
//  Created by 蒋艺 on 2023/8/31.
//

import Foundation
public protocol GraphProtocol {
    init(vertices: Int)
    /// init from input stream
    mutating func addEdge(from left: Int, to right: Int)
    func adjacent(to vertice: Int) -> [Int]
    var verticeCount: Int { get }
    var edgeCount: Int { get set }
    
    func degree(of vertice: Int) -> Int
    func maxDegree() -> Int
    func averageDegree() -> Double
    func numberOfSelfLoops() -> Int
}

extension GraphProtocol {
    func degree(of vertice: Int) -> Int {
        adjacent(to: vertice).count
    }
    func maxDegree() -> Int {
        (0..<verticeCount)
            .map { degree(of: $0) }
            .max() ?? 0
    }
    func averageDegree() -> Double {
        (0..<verticeCount)
            .map { degree(of: $0) }
            .reduce(0) { $0 + Double($1) }  / Double(verticeCount)
    }
    
    func numberOfSelfLoops() -> Int {
        (0..<verticeCount)
            .filter { adjacent(to: $0).contains($0) }
            .count / 2
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

