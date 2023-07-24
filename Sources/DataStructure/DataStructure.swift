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


// TODO: Construct Tree, List and Graph using indirect enum in swift, is it Functional programming?
public enum TreeNode<Element> {
    case empty
    indirect case node(value: Element, left: TreeNode<Element>, right: TreeNode<Element>)
}

public enum ListNode<Element: Comparable>: CustomStringConvertible {
    case empty
    indirect case node(value: Element, next: ListNode<Element> = .empty )
    
    public var description: String {
        switch self {
        case .empty:
            return ""
        case .node(let value, let next):
            let valueDescript = "\(value)"
            if case .node(_ , _) = next {
                return valueDescript + " -> " + next.description
            }else{
                return valueDescript
            }
        }
    }
    
    public mutating func remove(_ element: Element) {
        guard case .node(let value, var next) = self else {
            return
        }
        next.remove(element)
        if value == element {
            self = next
        }else{
            self = .node(value: value, next: next)
        }
    }
    
    // TODO: remove a element
    public func removed(_ element: Element) -> Self {
        var newList = self
        newList.remove(element)
        return newList
    }
    
    public init() {
        self = .empty
    }
    
    public init(_ element: Element) {
        self = .node(value: element, next: .empty)
    }
    
    public init(_ element: Element, _ nextNode: Self) {
        self = .node(value: element, next: nextNode)
    }
}

extension ListNode: Sequence where Element: Comparable {
    public typealias Iterator = ListIterator
    public func makeIterator() -> Iterator {
        return ListIterator(list: self)
    }
    public struct ListIterator: IteratorProtocol {
        var list: ListNode<Element>
        
        init(list: ListNode<Element>) {
            self.list = list
        }
        
        mutating public func next() -> Element? {
            switch list {
            case .empty:
                return nil
            case let .node(value, next):
                self.list = next
                return value
            }
       }
    }
}


//public class Tree<Element: Comparable> {
//    public var value: Element
//    public var left: Tree<Element>?
//    public var right: Tree<Element>?
//    
//    public init(value: Element, left: Tree<Element>? = nil, right: Tree<Element>? = nil) {
//        self.value = value
//        self.left = left
//        self.right = right
//    }
//    
//    private func rotateRight(h: Tree) -> Tree? {
//        let x = h.left
//        h.left = x?.right
//        x?.right = h
//        return x
//    }
//    
//    private func rotateLeft(h: Tree) -> Tree? {
//        let x = h.right
//        h.right = x?.left
//        x?.left = h
//        return x
//    }
//}
//

public protocol MinPQ {
    associatedtype Item: Comparable
    func add(_ x: Item)
    func getSmallest() -> Item
    func removeSmallest() -> Item
    var size: Int { get }
}




