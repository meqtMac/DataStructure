//
//  File.swift
//  
//
//  Created by 蒋艺 on 2023/8/23.
//

import Foundation
protocol PercolationStatsProtocol {
    /// perform independent trials on an n-by-n grid
    init(n: Int, trials: Int)
    /// sample mean of percolation threshold
    var mean: Double { get }
    /// sample standard deviation of percolation threshold
    var stddev: Double { get }
    /// low endpoint of 95% confidence interval
    var confidenceLow: Double { get }
    /// high endpoint of 95% confidence interval
    var confidenceHi: Double { get }
}

struct PercolationStats: PercolationStatsProtocol, CustomDebugStringConvertible {
    let n: Int
    let trials: Int
    let probailities: [Double]
    let mean: Double
    let stddev: Double
    let confidenceLow: Double
    let confidenceHi: Double
    
    var debugDescription: String {
        """
        n: \(n)
        trials: \(trials)
        mean: \(mean)
        stddev: \(stddev)
        95% confidence interval: \(confidenceLow) ~ \(confidenceHi)
        """
    }
    
    init(n: Int, trials: Int) {
        self.n = n
        self.trials = trials
        var pLists = [Double](repeating: 0, count: trials)
        for trial in 0..<trials {
            var percolation = Percolation(n: n)
            while !percolation.percolates() {
                let row = Int.random(in: 0..<n)
                let column = Int.random(in: 0..<n)
                percolation.open(row: row, column: column)
            }
            let ratio = Double(percolation.numberOfOpenSites()) / Double( n * n)
            pLists[trial] = ratio
        }
        let average = pLists.reduce(0) { partialResult, p in partialResult + p } / Double(trials)
        self.stddev = pLists.reduce(0) { partialResult, p in partialResult + (p - average) * (p - average) } / Double(trials - 1).squareRoot()
        self.mean = average
        self.confidenceLow = mean - 1.96 * stddev / sqrt(Double(trials))
        self.confidenceHi = mean + 1.96 * stddev / sqrt(Double(trials))
        self.probailities = pLists
    }
    
}
