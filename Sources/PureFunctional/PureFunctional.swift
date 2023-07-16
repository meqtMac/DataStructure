//
//  File.swift
//  
//
//  Created by 蒋艺 on 2023/7/16.
//

import Foundation

public enum TreeNode<Element> {
    case leaf(value: Element)
    indirect case node(value: Element, leftChild: Self, rightChild: Self )
}
