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
    typealias Vertice = Int
    init(vertices: Int)
    mutating func addEdge(from v: Vertice, to w: Vertice )
    associatedtype AdjecentVertices: Sequence<Self.Vertice>
    func adjecentVertices(from v: Vertice) -> AdjecentVertices
    var verticesCount: Int { get }
    var edgeCount: Int { get }
}

public extension DiGraphProtocol {
    /// reverse postorder for a *DAG*, where the first element have zero in degree.
    func depthFirstOrder() -> [Vertice] {
        var marked = [Bool](repeating: false, count: self.verticesCount)
        var reversePostStack: [Vertice] = []
        
        func dfs(from vertice: Vertice) {
            marked[vertice] = true
            for adjacent in self.adjecentVertices(from: vertice) {
                if !marked[adjacent] {
                    dfs(from: adjacent)
                }
            }
            reversePostStack.append(vertice)
        }
        
        for i in 0..<self.verticesCount {
            if !marked[i] {
                dfs(from: i)
            }
        }
        return reversePostStack.reversed()
    }
}

public extension DiGraphProtocol {
    func reversed() -> Self {
        var graph = Self.init(vertices: verticesCount)
        for vertice in 0..<verticesCount {
            for adjacent in adjecentVertices(from: vertice) {
                graph.addEdge(from: adjacent, to: vertice)
            }
        }
        return graph
    }
}

public extension DiGraphProtocol {
    /// if the Digraph is a Directe Acylic Graph
    /// - Complexity: `O(Edge+Vertice)` 
    func acylic() -> Bool {
        var inDegrees = [Int](repeating: 0, count: verticesCount)
        
        for vertice in 0..<verticesCount {
            for adjacent in adjecentVertices(from: vertice) {
                inDegrees[adjacent] += 1
            }
        }
        
        var queue = (0..<verticesCount).filter { inDegrees[$0] == 0 }
        while !queue.isEmpty {
            let v = queue.removeFirst()
            for adjacent in adjecentVertices(from: v) {
                inDegrees[adjacent] -= 1
                if inDegrees[adjacent] == 0 {
                    queue.append(adjacent)
                }
            }
        }
        
        return (0..<verticesCount).allSatisfy { inDegrees[$0] == 0 }
    }
}
/// Adjacency-lists digraph representation
public struct Digraph: DiGraphProtocol {
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

/**
 Digraph Search
 - DFS is a digraph algorithm.
 - Reachability
 - Path finding
 - Topological sort
 - Directed cycle detection
 */

/**
 Breadth first search
 - web crawler
 -
 */


/**
 Topological Sort
 - DAG: Directed `acyclic` graph
 - Topological sort: Redraw DAG so all edges point upwards.
 - Run depth-first search
 - Return vertices in reverse postorder
 */


/**
 Strong-connected components
 - Vertice v and w are strongly connected if there is a directed path from v to w and a directed path from w to v.
 - is an equivalence relations
 
 Reverse graph: Strong components in Graph are same as in Graph.reversed
 Kernal DAG: Contract each strong component into a single vertex.
 */

/**
 Phase 1: Compute reverse postorder in Graph.reversed
 Phase 2: Run DFS in Graph, visiting unmarked vertices in reverse postorder of Graph.reversed.
 */


/**
 Define v => w; there is a path from v to w; v' => w' there is a path from v to w in digraph.reversed.
 v `<` w in depthFirstOrder means v is before w in topological order.
 Proof: if v => w && !(w=>v)
 then w' => v' and !(v' => w')
 thus in digraph.reversed().depthFirstOrder w' `<` v' which mean's visited[w'] = true;
 else v' => w'
 thus w => v && v => w so w and v are strongly connected. traverse the graph, using dfs on v we can get all w that v => w. thus we can have all find all strongly connected components.
 */
public struct StrongConnectedComponents<Graph: DiGraphProtocol> {
    let count: Int
    /// id of vertice in 0..<vertices.count
    let id: [Int]
    
    init(from digraph: Graph) {
        let reversePostOrder = digraph.reversed().depthFirstOrder()
        var compoentMap: [Graph.Vertice : Int] = [:]
        var visited = [Bool](repeating: false, count: digraph.verticesCount)
        var count = 0
        
        func dfs(from vertice: Graph.Vertice) {
            visited[vertice] = true
            compoentMap[vertice] = count
            for adjacent in digraph.adjecentVertices(from: vertice) {
                if !visited[adjacent] {
                    dfs(from: adjacent)
                }
            }
        }
        
        for vertice in reversePostOrder {
            if !visited[vertice] {
                dfs(from: vertice)
                count += 1
            }
        }
        
        
        self.count = count
        self.id = (0..<digraph.verticesCount).map { compoentMap[$0]! }
    }
}

public extension DiGraphProtocol {
    var strongConnectedComponets: StrongConnectedComponents<Self> {
        StrongConnectedComponents(from: self)
    }
}
