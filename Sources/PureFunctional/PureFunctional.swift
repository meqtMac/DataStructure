//
//  File.swift
//
//
//  Created by 蒋艺 on 2023/7/16.
//

import Foundation

public enum TreeNode<Element> {
    case leaf
    indirect case node(value: Element, leftChild: Self, rightChild: Self )
    
    public var count: Int {
        switch self {
        case .leaf:
            return 0
        case .node(_, let leftChild, let rightChild):
            return 1 + leftChild.count + rightChild.count
        }
    }
    
   public init(@TreeNodeBuilder _ node: () -> Self ) {
        self = node()
    }
    
   @resultBuilder
    public enum TreeNodeBuilder {
        public typealias Node = TreeNode<Element>
        
        public static func buildBlock(_ element: Element, _ left: Node, _ right: Node) -> Node {
            return .node(value: element, leftChild: left, rightChild: right)
        }
        
        public static func buildBlock(_ element: Element, _ left: Node) -> Node {
            return .node(value: element, leftChild: left, rightChild: .leaf)
        }
        
        public static func buildBlock(_ left: Node, _ element: Element, _ right: Node) -> Node {
            return .node(value: element, leftChild: left, rightChild: right)
        }
        
        public static func buildBlock(_ left: Node, _ element: Element) -> Node {
            return .node(value: element, leftChild: left, rightChild: .leaf)
        }
        
        public static func buildBlock(_ element: Element) -> Node {
            return .node(value: element, leftChild: .leaf, rightChild: .leaf)
        }
        
        public static func buildBlock(_ node: Node) -> Node {
            return node
        }
    }
    
}

