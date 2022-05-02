//
//  Symbol.swift
//  SFSymbolsQuiz
//
//  Created by MacBook Pro M1 on 2022/05/02.
//

import Foundation

struct SFSymbol: Codable, Hashable {
    var name: String
    var categories: [String]
}

func loadSFSymbolsList() -> [SFSymbol] {
    guard let url = Bundle.main.url(forResource: "sfsymbols_categories_list", withExtension: "json") else {
        fatalError("Error: File is not found")
    }
    
    guard let data = try? Data(contentsOf: url) else {
        fatalError()
    }
    
    let decoder = JSONDecoder()
    guard let sfSymbols = try? decoder.decode([SFSymbol].self, from: data) else {
        fatalError()
    }
    
    return sfSymbols
}
