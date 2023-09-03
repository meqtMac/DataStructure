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


protocol DequeProtocol: Sequence {
    associatedtype Element
    var isEmpty: Bool { get }
    var count: Int { get }
    mutating func addFirst(_ element: Element)
    mutating func addLast(_ element: Element)
    mutating func removeFirst() -> Element?
    mutating func removeLast() -> Element?
}


//public struct Deque<Element>: Sequence {
//    public var isEmpty: Bool
//    public var count: Int
//}

@propertyWrapper
struct CodedAsString: Codable {
    var wrappedValue: Double
    init(wrappedValue: Double) {
        self.wrappedValue = wrappedValue
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let str = try container.decode(String.self)
        guard let value = Double(str) else {
            let error = EncodingError.Context(
                codingPath: container.codingPath,
                debugDescription: "Invaild string representation of double value"
            )
            throw EncodingError.invalidValue(str, error)
        }
        wrappedValue = value
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(String(wrappedValue))
    }
}

struct Coordinate: Codable {
    @CodedAsString var latitude: Double
    @CodedAsString var longitude: Double
}
