//
//  File.swift
//  
//
//  Created by 蒋艺 on 2023/8/23.
//

import Foundation
import ArgumentParser

@main
struct Simulation: ParsableCommand {
    @Flag(name: .shortAndLong, help: "verbose")
    var verbose = false
    
    @Argument(help: "n * n grid size")
    var n: Int
    
    @Argument(help: "Trails")
    var trials: Int
    
    mutating func run() throws {
        guard n > 0 && trials > 1 else {
            throw PercolationError.illegalArgumentException
        }
        
        let duration = SuspendingClock().measure {
            let stats = PercolationStats(n: n, trials: trials)
            print(PercolationStats(n: n, trials: trials))
            if verbose {
                print(stats.probailities)
            }
        }
        if verbose {
            print(duration)
        }
    }
}
