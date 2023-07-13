//
//  File.swift
//  
//
//  Created by 蒋艺 on 2023/7/12.
//

import Foundation

protocol StackProtocol<Element> {
    associatedtype Element
    mutating func push(_ element: Element)
    mutating func pop() -> Element?
    var isEmpty: Bool { get }
    var count: Int { get }
}

public protocol QueueProtocol<Element> {
    associatedtype Element
    var isEmpty: Bool { get }
    var first: Element { get set }
    var last: Element { get set }
    
    mutating func enqueue(_ element: Element)
    mutating func dequeue() -> Element?
}

struct MyStack<Element>: StackProtocol {
    
    mutating func push(_ element: Element) {
        data.append(element)
    }
    
    mutating func pop() -> Element? {
        data.popLast()
    }
    
    var isEmpty: Bool {
        data.isEmpty
    }
    
    var count: Int {
        data.count
    }
    
    var data: [Element]
    
    init(_ data: [Element]) {
        self.data = data
    }
}

public class Evaluator {
    public static func evaluate(_ statement: String) -> Double {
        
        var operators: MyStack<String> = .init([])
        var values: MyStack<Double> = .init([])
        
        let tokens = statement.split(separator: " ")
        for token in tokens {
            let str = String(token)
            if token == "(" {
                continue
            }else if token == "+" {
                operators.push(str)
            }else if token == "*" {
                operators.push(str)
            }else if token == ")" {
                let op = operators.pop()!
                if op == "+" {
                    let v1 = values.pop()!
                    let v2 = values.pop()!
                    values.push(v1+v2)
                }else if op == "*" {
                    let v1 = values.pop()!
                    let v2 = values.pop()!
                    values.push(v1 + v2)
                }
            }else {
                values.push(try! Double(str, format: .number))
            }
        }
        return values.pop()!
    }
}

