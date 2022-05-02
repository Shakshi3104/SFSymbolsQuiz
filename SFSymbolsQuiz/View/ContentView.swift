//
//  ContentView.swift
//  SFSymbolsQuiz
//
//  Created by MacBook Pro M1 on 2022/05/02.
//

import SwiftUI

struct ContentView: View {
    
    private let symbols = loadSFSymbolsList()
    
    var body: some View {
        List {
            ForEach(symbols, id: \.self) { symbol in
                
                HStack {
                    Image(systemName: symbol.name)
                        .padding(.horizontal, 5)
                    Text(symbol.name)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
