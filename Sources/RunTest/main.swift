//
//  File.swift
//  
//
//  Created by 蒋艺 on 2023/6/20.
//

//func makeCaculator(maximum: Int) -> (Int) -> Int {
//    var cache = [Int?](repeating: nil, count: maximum)
//    
//    func fibCaculator(n: Int) -> Int {
//        if cache[n] == nil {
//            if n < 2 {
//                cache[n] = n
//            }else{
//                cache[n] = fibCaculator(n: n-1) + fibCaculator(n: n-2)
//            }
//        }
//        return cache[n] ?? 0
//    }
//    
//    return fibCaculator
//}
//
//let maximum = 60
//let calculator = makeCaculator(maximum: maximum)
//
//let _ = (0..<maximum).map { n in
//    var result: Int = 0
//    let duration = SuspendingClock().measure {
//        result = calculator(maximum - 1 - n)
//    }
//    print(maximum - 1 - n, result, duration, separator: "\t")
//}

//import Foundation

//let stdout = FileHandle.standardOutput

//import DataStructure
//
//let threeToGo = CountDown(count: 3)
//
//for i in threeToGo {
//    print(i)
//}
//
//let header: HTMLNode = .element(name: "h1", children: .fragment([
//    .text("Hello "),
//    .element(name: "em", children: .text("World"))
//]))
//
////print(header)
//print(header.contains{ node in
//    guard case .element(name: "em", _, _) = node else { return false}
//    return true
//})
//
//print(header.compactMap{ node -> String? in
//    guard case let .text(t) = node else { return nil }
//    return t
//})
//
//let arr = [10, 20, 30]
//print( MemoryLayout.size(ofValue: arr) )

//var arr: [Int] = []
//for i in (1...10000) {
//    arr.append(i)
//    print("|\(arr.count)|\(arr.capacity)|")
//}
//
//for _ in (1...10000) {
////    arr.removeLast()
//    let _ = arr.popLast()
//    print("|\(arr.count)|\(arr.capacity)|")
//}
//
//struct BigStruct {
//    var big: [Int] = [Int](repeating: 1, count: 1024)
//}
//
//var bigArr = [BigStruct]()
//
//for _ in (1...1024*128) {
//    bigArr.append(BigStruct())
//    print("|\(bigArr.count)|\(bigArr.capacity)|")
//}
//
//for _ in (1...128) {
//    for _ in (0..<1024) {
//        let _ = bigArr.popLast()
//    }
//    print("|\(bigArr.count)|\(bigArr.capacity)|")
//}
//
//var hugeIntArr = [Int]()
//
//for _ in (0..<16) {
//    for i in (0..<1024*1024) {
//        hugeIntArr.append(i)
//    }
//    print("|\(hugeIntArr.count)|\(hugeIntArr.capacity)|")
//}
//
//for i in (1...2) {


//    for _ in (1...1024*1024*8) {
//        hugeIntArr.removeLast()
//    }
//    print("|\(i)|\(hugeIntArr.count)|\(hugeIntArr.capacity)|")
//}

//print("end")

import DataStructure

/// reminds me of some lisp code 😇
//var list = ListNode(1, .node(value: 2, next: .node(value: 3, next: .node(value: 4, next: .empty))))
//var list = ListNode(1) -> ListNode(2) -> ListNode(3)

precedencegroup ListPrecedence {
    higherThan: AdditionPrecedence
    lowerThan: MultiplicationPrecedence
    associativity: right
    assignment: false
}
infix operator =>: ListPrecedence


extension ListNode where Element: Comparable {
    static func => (_ lhs: Self, _ rhs: Self) -> Self {
        switch lhs {
        case .empty:
            return rhs
        case let .node(value, next):
            return .node(value: value, next: next => rhs)
        }
    }
}

var list = ListNode(1, .empty) => ListNode(2) => ListNode(3, .node(value: 4)) => ListNode(5) => .empty

print("origin:", list)
list.remove(2)
print("after remove:", list)
print("removed", list.removed(1))
print("list after removed", list)

for var node in list {
    node += 1
    print(node + 2)
}
print(list)



import Collections

let heap: Heap = .init(arrayLiteral: 1, 3, 4, 5)
print(heap)
