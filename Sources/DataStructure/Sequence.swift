//
//  File.swift
//  
//
//  Created by 蒋艺 on 2023/7/10.
//

import Foundation
public struct CountDown: Sequence, IteratorProtocol {
    public typealias Element = Int
    var count: Int
    
    public init(count: Int) {
        self.count = count
    }
     
    mutating public func next() -> Int? {
        if count == 0 {
            return nil
        } else {
            defer { count -= 1}
            return count
        }
    }
    
}


public struct ConstantIterator: IteratorProtocol {
    mutating public func next() -> Int? {
        1
    }
}

public struct FibsIterator: IteratorProtocol {
    public typealias Element = Int
    var state = (0, 1)
    mutating public func next() -> Int? {
        let upcomingNumber = state.0
        state = (state.1, state.0 + state.1)
        return upcomingNumber
    }
}

public enum HTMLNode: Hashable {
    case text(String)
    indirect case element(
        name: String,
        attributes: [String: String] = [:],
        children: HTMLNode = .fragment([])
    )
    case fragment([HTMLNode])
}

public struct HTMLNodeIterator: IteratorProtocol {
    public typealias Element = HTMLNode
    var remaining: [HTMLNode]
    
    mutating public func next() -> HTMLNode? {
        guard !remaining.isEmpty else { return nil}
        let result = remaining.removeFirst()
        switch result {
        case .text(_):
            break
        case .element(name: _, attributes: _ , children: let children):
            remaining.append(children)
        case .fragment(let elements):
            remaining.append(contentsOf: elements)
        }
        return result
    }
}

extension HTMLNode: Sequence {
    public typealias Iterator = HTMLNodeIterator
    public func makeIterator() -> Iterator {
        HTMLNodeIterator(remaining: [self])
    }
}
