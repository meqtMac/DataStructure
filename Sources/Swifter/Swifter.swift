//
//  File.swift
//  
//
//  Created by 蒋艺 on 2023/7/10.
//

import Foundation


protocol Vehicle {
    var numberOfWheels: Int { get }
    var color: Int { get set }
    
    mutating func changeColor()
}

struct MyCar: Vehicle {
    func changeColor() {
    }
   var color: Int = 0
    var numberOfWheels: Int = 4
}

//public func incrementor(variable: let int ) -> Int {
//    return variable + 1
//}
public protocol MatrixSettable<Element, Index> {
    associatedtype Element
    associatedtype Index
    subscript(index: Index) -> Element { get }
}

extension Double: MatrixSettable {
    public typealias Index = Int
    
    public typealias Element = Self
    
    public subscript(index: Int) -> Double {
        self
    }
}

extension Bool: MatrixSettable {
    public typealias Index = Int
    public typealias Element = Self
    public subscript(index: Int) -> Bool {
        self
    }
}

extension Array: MatrixSettable where Element: MatrixSettable { }



public struct Matrix<Element> where
Element: MatrixSettable,
Element.Index == Int,
Element.Element == Element {
    public typealias Index = Int
    let rowCount: Index
    let columnCount: Index
    
    private var data: [Element]
    
    init(rowCount: Index, columnCount: Index, data: [Element]) {
        self.rowCount = rowCount
        self.columnCount = columnCount
        self.data = data
    }
    
    public static func isSameShape(_ lhs: Self, _ rhs: Self) -> Bool {
        return lhs.columnCount == rhs.columnCount ||
        lhs.rowCount == rhs.rowCount
    }
    private func vaild(row: Index) -> Bool {
        return 0 <= row && row < rowCount
    }
    
    private func vaild(column: Index) -> Bool {
        return 0 <= column && column < columnCount
    }
    
    public subscript(row: Index, column: Index) -> Element {
        get {
            assert(vaild(row: row) && vaild(column: column))
            return data[row*columnCount + column]
        }
        set {
            assert(vaild(row: row) && vaild(column: column))
            data[row*columnCount + column] = newValue
        }
    }
    
    public subscript(grid: Matrix<Bool>) -> some MatrixSettable<Element, Index>   {
        get {
            let count = grid.data.filter{$0}.count
            var arr = Array(repeating: data[0], count: count)
            return arr
        }
        set {
            let count = grid.data.filter { $0 }.count
            for i in 0..<count {
                data[i] = newValue[i]
            }
        }
    }
    
   
}
