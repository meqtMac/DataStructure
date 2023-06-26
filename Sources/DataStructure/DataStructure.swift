public protocol DisjointSetsProtocol {
    mutating func connect(p: Int, q: Int)
    func isConnected(p: Int, q: Int) -> Bool
}

public struct QuickFindDS: DisjointSetsProtocol {
    private var id: [Int]
    public init(n: Int) {
        self.id = (0..<n).map {$0}
    }
    
    /// `O(n)`
    public mutating func connect(p: Int, q: Int) {
        let pId = id[p]
        let qId = id[q]
        
        for i in 0..<id.count {
            if id[i] == pId {
                id[i] = qId
            }
        }
    }
    
    /// `O(1)`
    public func isConnected(p: Int, q: Int) -> Bool {
        id[p] == id[q]
    }
}

public struct QuickUnionDS: DisjointSetsProtocol {
    
    private var parent: [Int]
    public init(n: Int) {
        self.parent = [Int](repeating: -1, count: n)
    }
    
    private func find(_ val: Int) -> Int {
        var index = val
        while (parent[index] >= 0 ) {
            index = parent[index]
        }
        return index;
    }
    
    public mutating func connect(p: Int, q: Int) {
        parent[find(q)] = parent[find(q)]
    }
    
    public func isConnected(p: Int, q: Int) -> Bool {
        find(p) == find(q)
    }
}


public class Tree<Element: Comparable> {
    public var value: Element
    public var left: Tree<Element>?
    public var right: Tree<Element>?
    
    public init(value: Element, left: Tree<Element>? = nil, right: Tree<Element>? = nil) {
        self.value = value
        self.left = left
        self.right = right
    }
    
    private func rotateRight(h: Tree) -> Tree? {
        var x = h.left
        h.left = x?.right
        x?.right = h
        return x
    }
    
    private func rotateLeft(h: Tree) -> Tree? {
        let x = h.right
        h.right = x?.left
        x?.left = h
        return x
    }
}

public protocol MinPQ {
    associatedtype Item: Comparable
    func add(_ x: Item)
    func getSmallest() -> Item
    func removeSmallest() -> Item
    var size: Int { get }
}




