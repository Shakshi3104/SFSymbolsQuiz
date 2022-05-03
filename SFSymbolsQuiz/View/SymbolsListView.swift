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
                CategorySelectionView(category: $selectedCategory)
            }
        }
    }
}

// MARK: -
struct CategorySelectionItemView: View {
    var categoryName: String
    var isSelected: Bool
    
    var body: some View {
        HStack {
            Text(categoryName)
            Spacer()
            if isSelected {
                Image(systemName: "checkmark")
                    .foregroundColor(.accentColor)
            }
        }
        .contentShape(Rectangle())
    }
}

struct CategorySelectionView: View {
    @Environment(\.dismiss) private var dismiss
    
    private let categories = SFSymbolsCategory.allCases
    @Binding var category: SFSymbolsCategory?
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    CategorySelectionItemView(
                        categoryName: "All",
                        isSelected: category == nil
                    )
                    .onTapGesture {
                        category = nil
                        dismiss()
                    }
                }
                
                Section {
                    ForEach(categories, id: \.self) { category in
                        CategorySelectionItemView(
                            categoryName: category.friendlyName(),
                            isSelected: self.category == category
                        )
                            .onTapGesture {
                                self.category = category
                                dismiss()
                            }
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
