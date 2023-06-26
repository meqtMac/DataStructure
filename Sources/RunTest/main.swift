//
//  File.swift
//  
//
//  Created by 蒋艺 on 2023/6/20.
//

func makeCaculator(maximum: Int) -> (Int) -> Int {
    var cache = [Int?](repeating: nil, count: maximum)
    
    func fibCaculator(n: Int) -> Int {
        if cache[n] == nil {
            if n < 2 {
                cache[n] = n
            }else{
                cache[n] = fibCaculator(n: n-1) + fibCaculator(n: n-2)
            }
        }
        return cache[n] ?? 0
    }
    
    return fibCaculator
}

let maximum = 60
let calculator = makeCaculator(maximum: maximum)

let _ = (0..<maximum).map { n in
    var result: Int = 0
    let duration = SuspendingClock().measure {
        result = calculator(maximum - 1 - n)
    }
    print(maximum - 1 - n, result, duration, separator: "\t")
}

//import Foundation

//let stdout = FileHandle.standardOutput
