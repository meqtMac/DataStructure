//
//  File.swift
//  
//
//  Created by 蒋艺 on 2023/9/5.
//

import Foundation
/**
 - Shortest path.
 - Topological sort.
 - Strong connectivity.
 - Transitive closure.
 - PageRank.
 */

public protocol DiGraphProtocol {
    associatedtype Vertice
    init(vertices: Int)
    mutating func addEdge(from v: Vertice, to w: Vertice )
    associatedtype AdjecentVertices: Sequence<Self.Vertice>
    func adjecentVertices(from v: Vertice) -> AdjecentVertices
    var verticesCount: Int { get }
    var edgeCount: Int { get }
    static func reverse() -> Self
}

/// Adjacency-lists digraph representation
public struct Digraph: DiGraphProtocol {
    public static func reverse() -> Digraph {
        // TODO: implementation
        fatalError("To be implementated.")
    }
    
    public typealias Vertice = Int
    public typealias AdjecentVertices = [Vertice]
    public let verticesCount: Vertice
    public var edgeCount: Vertice {
        adjacencyList.reduce(0) { partialResult, vertices in
            partialResult +  vertices.count
        }
    }
    private var adjacencyList: [AdjecentVertices]
    
    public init(vertices: Int) {
        verticesCount = vertices
        adjacencyList = .init(repeating: [], count: vertices)
    }
    
    public mutating func addEdge(from v: Vertice, to w: Vertice) {
        adjacencyList[v].append(w)
    }
    
    public func adjecentVertices(from v: Vertice) -> AdjecentVertices {
        adjacencyList[v]
    }
    
}
