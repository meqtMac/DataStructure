//
//  File.swift
//  
//
//  Created by 蒋艺 on 2023/8/23.
//

import XCTest
@testable import Percolation

final class DataStructureTests: XCTestCase {
    func testExample() throws {
        measure(metrics: [XCTCPUMetric(), XCTClockMetric(), XCTMemoryMetric()]) {
            PercolationStats(n: 1000, trials: 10)
        }
    }
}
