//
//  File.swift
//  
//
//  Created by 蒋艺 on 2023/7/23.
//

import Foundation
// Challenge:
protocol PiorityQueueProtocol {
    associatedtype Element: Comparable
    var count: Int { get }
    var isEmpty: Bool { get }
    mutating func insert(_ value: Element)
    mutating func delMax() -> Element
    var maximum: Element { get }
    init(capacity: Int)
}

struct BinaryHeap<Element> where Element: Comparable {
    private(set) var elements: [Element]
    
    init(elements: [Element]) {
        self.elements = elements
    }
    
    mutating func insert(value: Element) {
        elements.append(value)
        swim(at: elements.count - 1)
    }
   
    private mutating func swim(at k: Int) {
        var k = k
        while(k > 1 && elements[k/2] < elements[k]) {
            elements.swapAt(k/2, k)
            k = k/2;
        }
    }
    
    private mutating func sink(at k: Int) {
        // mutable copy
        var current = k
        let N = elements.count - 1
        while (2*current <= elements.count - 1) {
            var j = 2*current
            // childs of k's Index are 2*k and 2*k + 1, choice the bigger one
            if j < N && elements[j] < elements[j+1] {j += 1 }
            if !(elements[current] < elements[j]) { break }
            elements.swapAt(current, j)
            current = j
        }
    }
    
    public mutating func deleleMax() -> Element {
        let max = elements[1]
        elements.swapAt(1, elements.count - 1)
        elements.removeLast()
        sink(at: 1)
        return max
    }
    
}

//struct StdDraw {
//    
//}
//
//struct Ball {
//    
//    private var positon: (x: CGFloat, y: CGFloat)
//    private var velocity: (x: CGFloat, y: CGFloat)
//    private let radius: CGFloat
//    
////    func move(_ value: CGFloat)
////    func draw(
//    
//    // time passed
//    mutating func move(deltaT: CGFloat) {
//        let dt = deltaT
//        // x collide
//        if (positon.x + velocity.x * dt < radius) || (positon.x + velocity.x * dt > 1.0 - radius) {
//            velocity = (-velocity.x, velocity.y)
//        }
//        // y collide
//        if (positon.y + velocity.y * dt < radius) || (positon.y + velocity.y * dt > 1.0 - radius) {
//            velocity = (velocity.x, velocity.y)
//        }
//        
//        positon.x += velocity.x * dt
//        positon.y += velocity.y * dt
//    }
//    
//    func draw() {
//        
//    }
//}
//
//public struct BouncingBalls {
//    func main() {
//        let n = 100
//        let balls = [Ball](repeating: Ball(), count: n)
//        while true {
//            StdDraw.clear()
//            for i in balls.indices {
//                balls[i].move(0.5)
//                balls[i].draw();
//            }
//            StdDraw.show()
//        }
//    }
//    
//}
