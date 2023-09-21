//
//  File.swift
//
//
//  Created by 蒋艺 on 2023/9/6.
//

//import Foundation
import Algorithm

public enum WordNetError: Error {
    case illegalArgument
    case noSuchPath
}

public protocol WordNetProtocol {
    /// throws `WordNetError` if input does not correspond to a rooted Directed Acyclic Graph
//    init(synsetsFilePath: String, hypernymFilePath: String) throws
    associatedtype Nouns: Sequence<String>
    var nouns: Nouns { get }
    func contain(word: String) -> Bool
    /// throws `WordNetError` if either input does not contained in Nouns
    func distance(between nounA: String, and nounB: String) throws -> Int
    /// a synset, that is the common ancester of `nounA` and `nounB` in a shortest ancester path.
    /// - Throws: `WordNetError` if either input does not contained in Nouns
    func sap(nounA: String, nounB: String) -> Int
}

public protocol SAPProtocol {
    init(digraph: any DiGraphProtocol)
    /// length of shortest ancestral path between `v` and `w`
    /// - Throws: `WordNetError` if no such path
    func length(between v: DiGraphProtocol.Vertice, w: DiGraphProtocol.Vertice) throws -> Int
    /// a common ancestor of v and w that participates in a shortest ancestral path
    ///  - Throws: `WordNetError`if no such path
    func ancestor(between v: DiGraphProtocol.Vertice, w: DiGraphProtocol.Vertice) -> DiGraphProtocol.Vertice
    
    associatedtype Vertices: Sequence<DiGraphProtocol.Vertice>
    
    ///  length of shortest ancestral path between any vertex in v and any vertex in w;
    ///  - Throws: `WordNetError` if no such path
    func length(between v: Vertices, w: Vertices) -> Int
    
    ///  a common ancester that participates in shortest ancestral path
    ///  - Throws: `WordNetError` if no such path
    func ancestor(between v: Vertices, w: Vertices) -> Digraph.Vertice
}


import Foundation
import RegexBuilder

@main
struct WordNet {
    let graph: Digraph
    
    init(graph: Digraph) {
        self.graph = graph
    }
    
    
    static func main() {
        let graphUrl = Bundle.module.url(forResource: "hypernyms", withExtension: "txt", subdirectory: "Resources")!
        let lines = try! String(contentsOf: graphUrl, encoding: .utf8)
            .components(separatedBy: .newlines)
            .lazy
            .filter { !$0.isEmpty }
        
        var graph = Digraph(vertices: lines.count)
        for line in lines {
            var components = line.components(separatedBy: ",")
            let index = Int(components[0])!
            components.removeFirst()
            for parent in components {
                graph.addEdge(from: index, to: Int(parent)!)
            }
        }
       
        let wordNet = WordNet(graph: graph)
        
    }
}
