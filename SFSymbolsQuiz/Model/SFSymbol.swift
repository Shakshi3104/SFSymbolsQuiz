//
//  Symbol.swift
//  SFSymbolsQuiz
//
//  Created by MacBook Pro M1 on 2022/05/02.
//

import Foundation

// MARK: - SFSymbol
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

// MARK: - SFSymbols Category
enum SFSymbolsCategory: String, CaseIterable {
    case whatsnew = "whatsnew"
    case multicolor = "multicolor"
    case communication = "communication"
    case weather = "weather"
    case objectsandtools = "objectsandtools"
    case devices = "devices"
    case gaming = "gaming"
    case connectivity = "connectivity"
    case transportation = "transportation"
    case human = "human"
    case nature = "nature"
    case editing = "editing"
    case textformatting = "textformatting"
    case media = "media"
    case keyboard = "keyboard"
    case commerce = "commerce"
    case time = "time"
    case health = "health"
    case shapes = "shapes"
    case arrows = "arrows"
    case indices = "indices"
    case math = "math"
    
    // MARK: Category frendly name
    func friendlyName() -> String {
        switch self {
        case .whatsnew:
            return "What's New"
        case .multicolor:
            return "Multicolor"
        case .indices:
            return "Indices"
        case .objectsandtools:
            return "Objects & Tools"
        case .devices:
            return "Devices"
        case .textformatting:
            return "Text Formatting"
        case .gaming:
            return "Gaming"
        case .transportation:
            return "Transportation"
        case .time:
            return "Time"
        case .health:
            return "Health"
        case .nature:
            return "Nature"
        case .keyboard:
            return "Keyboard"
        case .connectivity:
            return "Connectivity"
        case .shapes:
            return "Shapes"
        case .weather:
            return "Weather"
        case .arrows:
            return "Arrows"
        case .communication:
            return "Communication"
        case .editing:
            return "Editing"
        case .media:
            return "Media"
        case .human:
            return "Human"
        case .commerce:
            return "Commerce"
        case .math:
            return "Math"
        }
    }
    
    // MARK: Category symbol name
    //        func symbolName() -> String {
    //            switch self {
    //            case .whatsnew:
    //                <#code#>
    //            case .multicolor:
    //                <#code#>
    //            case .communication:
    //                <#code#>
    //            case .weather:
    //                <#code#>
    //            case .objectsandtools:
    //                <#code#>
    //            case .devices:
    //                <#code#>
    //            case .gaming:
    //                <#code#>
    //            case .connectivity:
    //                <#code#>
    //            case .transportation:
    //                <#code#>
    //            case .human:
    //                <#code#>
    //            case .nature:
    //                <#code#>
    //            case .editing:
    //                <#code#>
    //            case .textformatting:
    //                <#code#>
    //            case .media:
    //                <#code#>
    //            case .keyboard:
    //                <#code#>
    //            case .commerce:
    //                <#code#>
    //            case .time:
    //                <#code#>
    //            case .health:
    //                <#code#>
    //            case .shapes:
    //                <#code#>
    //            case .arrows:
    //                <#code#>
    //            case .indices:
    //                <#code#>
    //            case .math:
    //                <#code#>
    //            }
    //        }
}

// MARK: - SFSymbols
struct SFSymbols {
    /// SF Symbol
    private let symbols: [SFSymbol]
    
    /// initializer
    init() {
        self.symbols = loadSFSymbolsList()
    }
    
    /// SF Symbols list
    func allCases(category: SFSymbolsCategory? = nil) -> [SFSymbol] {
        if let category = category {
            return symbols.filter { symbol in
                return symbol.categories.contains(category.rawValue)
            }
        }
        return symbols
    }
}
