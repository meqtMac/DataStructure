//
//  File.swift
//  
//
//  Created by 蒋艺 on 2023/7/9.
//

public protocol UnionFound {
    /// init union-found data structure with N objects (0 to N-1)
    init(n: Int)
    /// add connections between q and p
    mutating func union( _ lhs: Int, _ rhs: Int)
    /// are q and p in the same components
    func isConnected(_ lhs: Int, _ rhs: Int) -> Bool
    /// component Identifier for p ( 0 to N - 1)
    func find(_ node: Int) -> Int
    /// number of components
    var count: Int { get }
}

// MARK: Quick find: find: check if p and q have the same id
public struct QuickFindUnion: UnionFound {
    
    private var nodes: [Int]
    
    private func tag(of node: Int) -> Int {
        nodes[node]
    }
    
    public mutating func union(_ q: Int, _ p: Int) {
        if isConnected(p, q) {
            return
        }
        
        for i in 0..<nodes.count {
            if tag(of: i) == tag(of: q) {
                nodes[i] = tag(of: q)
            }
        }
        
    }
    
    public func isConnected(_ p: Int, _ q: Int) -> Bool {
        nodes[q] == nodes[p]
    }
    
    public func find(_ p: Int) -> Int {
        return 0
    }
    
    public var count: Int {
        nodes.count
    }
    
    public init(n: Int) {
        self.nodes = (0..<n).map{$0}
    }
}

public struct QuickUnion: UnionFound {
    private var nodes: [Int]
    public init(n: Int) {
        self.nodes = (0..<n).map {$0}
    }
    
    public mutating func union(_ lhs: Int, _ rhs: Int) {
        let markLhs = find(lhs)
        let markRhs = find(rhs)
        if markLhs == markRhs {
            return
        }
        nodes[markLhs] = markRhs
    }
    
    public func isConnected(_ p: Int, _ q: Int) -> Bool {
        return find(p) == find(q)
    }
    
    public func find(_ node: Int) -> Int {
        var id = nodes[node]
        while nodes[id] != id {
            id = nodes[id]
        }
        return id
    }
    
    public var count: Int {
        nodes.count
    }
}
