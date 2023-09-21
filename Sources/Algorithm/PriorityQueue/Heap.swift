//
//  File.swift
//  
//
//  Created by 蒋艺 on 2023/9/1.
//

import Foundation

/**
Complete Binary Tree
Height of complete tree with N nodes is `log(N)`
 
 Heap-ordered binary tree
 - Keys in nodes
 - Parent's key no smaller thatn children's keys
 - Proposition. Largest key is a[1], which is root of binary tree.
*/
public struct Heap<Element: Comparable> {
    typealias Index = Int
    private let comparator: (Element, Element) -> Bool
    /// elements are `0` indexed
    private var elements: [Element]
    
    public init(comparator: @escaping (Element, Element) -> Bool ) {
        self.comparator = comparator
        self.elements = []
    }
    
    public init(from array: [Element], comparator: @escaping (Element, Element) -> Bool = { $0 < $1 } ) {
        self.elements = []
        self.comparator = comparator
        for element in array {
            insert(element)
        }
    }
    
    public mutating func insert(_ key: Element) {
        elements.append(key)
        swim(at: count - 1)
    }
    
    public mutating func pop() -> Element? {
        guard !elements.isEmpty else {
            return nil
        }
        elements.swapAt(0, count - 1)
        let max = elements.removeLast()
        sink(at: 0)
        return max
    }
    
    public var top: Element? {
        elements.first
    }
    
    public var isEmtpy: Bool {
        elements.isEmpty
    }
    
    public var count: Int {
        elements.count
    }
    
    /// repeat until heap order perserved
    private mutating func swim(at k: Index) {
        // index here after are `1` indexed
        var currentIndex = k + 1
        while currentIndex > 1 && !comparator(elements[currentIndex/2-1], elements[currentIndex-1]) {
            elements.swapAt(currentIndex/2-1, currentIndex-1)
            currentIndex = currentIndex / 2
        }
    }
    
    private mutating func sink(at k: Index) {
        // translate k to 1 index for easier tree indexing
        var current = k + 1
        let count = count
        while 2*current <= count {
            let nextIndex: Int = { [current, count] in
                let left = 2 * current
                let right = left + 1
                return (left < count && !comparator(elements[left-1], elements[right-1]) ) ? right : left
            }()
            
            if comparator(elements[current-1], elements[nextIndex-1]) {
                break;
            }
            elements.swapAt(current - 1, nextIndex - 1)
            current = nextIndex
        }
    }
}


//extension Array where Element: Comparable {
//    public mutating func heapSorted() {
//        let size = count
//        for k in 1...size/2 {
//            sink(at: size/2 + 1 - k, bounds: size)
//        }
//        for n in 2...size {
//            swapAt(1, size + 2 - n)
//            sink(at: 1, bounds: size + 2 - n - 1)
//        }
//    }
//    
//    private mutating func sink(at k: Int, bounds N: Int) {
//        var current = k + 1
//        let count = N
//        while 2*current <= count {
//            let nextIndex: Int = { [current, count] in
//                let left = 2 * current
//                let right = left + 1
//                return (left < count && self[left-1] < self[right-1]) ? right : left
//            }()
//            
//            if self[current-1] < self[nextIndex-1] {
//                break;
//            }
//            self.swapAt(current - 1, nextIndex - 1)
//            current = nextIndex
//        }
// 
//    }
//    
//}
