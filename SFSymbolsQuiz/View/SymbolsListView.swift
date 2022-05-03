//
//  SymbolListView.swift
//  SFSymbolsQuiz
//
//  Created by MacBook Pro M1 on 2022/05/03.
//

import SwiftUI

// MARK: - SymbolsListView
struct SymbolsListView: View {
    private let symbols = SFSymbols()

    @State private var selectedCategory: SFSymbolsCategory? = nil
    private var filteredSymbolsList: [SFSymbol] {
        symbols.allCases(category: selectedCategory)
    }
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredSymbolsList, id: \.self) { symbol in
                    
                    HStack {
                        Image(systemName: symbol.name)
                            .padding(.horizontal, 5)
                        Text(symbol.name)
                        Spacer()
                        Text(SFSymbolsCategory.init(rawValue: symbol.categories.first!)?.friendlyName() ?? "N/A")
                            .foregroundColor(.secondary)
                            .font(.caption)
                    }
                }
            }
            .navigationTitle("SF Symbols")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        // Category filter action
                        isPresented.toggle()
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                }
            }
            .sheet(isPresented: $isPresented) {
                // dismiss
            } content: {
                CategorySelectionView()
            }
        }
    }
}

// MARK: -
struct CategorySelectionView: View {
    private let categories = SFSymbolsCategory.allCases
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Text("All")
                }
                
                Section {
                    ForEach(categories, id: \.self) { category in
                        Text(category.friendlyName())
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        
                    } label: {
                        Text("Cancel")
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        
                    } label: {
                        Text("Done")
                    }
                    
                }
            }
        }
    }
}

// MARK: -
struct SymbolListView_Previews: PreviewProvider {
    static var previews: some View {
        SymbolsListView()
    }
}
