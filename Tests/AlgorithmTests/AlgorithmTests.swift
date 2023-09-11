//
//  File.swift
//  
//
//  Created by 蒋艺 on 2023/9/8.
//

//import Foundation

import XCTest
@testable import Algorithm

final class DataStructureTests: XCTestCase {
    func testExample() throws {
//        measure(metrics: [XCTCPUMetric(), XCTClockMetric(), XCTMemoryMetric()]) {
//            _ = PercolationStats(n: 1000, trials: 10)
//        }
        
        let testGraph: Digraph  = {
            var graph = Digraph(vertices: 10)
            for i in 0..<10 {
                for j in 0..<10 {
                    graph.addEdge(from: i, to: j)
                }
            }
            return graph
        }()
        
        XCTAssertEqual(testGraph.verticesCount, 10 )
        XCTAssertEqual(testGraph.edgeCount, 100)
        
        let vertices = (0..<testGraph.verticesCount).map { $0 }
        // Test adjacent vertices
        for i in vertices {
            XCTAssertEqual(testGraph.adjecentVertices(from: i), vertices)
        }
    }
    
    func testDiGraph() throws {
        let graph = {
            var graph = Digraph(vertices: 13)
            graph.addEdge(from: 4, to: 2)
            graph.addEdge(from: 2, to: 3)
            graph.addEdge(from: 3, to: 2)
            graph.addEdge(from: 6, to: 0)
            graph.addEdge(from: 0, to: 1)
            graph.addEdge(from: 2, to: 0)
            graph.addEdge(from: 11, to: 12)
            graph.addEdge(from: 12, to: 9)
            graph.addEdge(from: 9, to: 10)
            graph.addEdge(from: 9, to: 11)
            graph.addEdge(from: 7, to: 9)
            graph.addEdge(from: 10, to: 12)
            graph.addEdge(from: 11, to: 4)
            graph.addEdge(from: 4, to: 3)
            graph.addEdge(from: 3, to: 5)
            graph.addEdge(from: 6, to: 8)
            graph.addEdge(from: 8, to: 6)
            graph.addEdge(from: 5, to: 4)
            graph.addEdge(from: 0, to: 5)
            graph.addEdge(from: 6, to: 4)
            graph.addEdge(from: 6, to: 9)
            graph.addEdge(from: 7, to: 6)
            return graph
        }()
        
        print(graph.depthFirstOrder())
       
    }
}
