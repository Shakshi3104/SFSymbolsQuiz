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
                            .frame(width: 30)
                        Spacer()
                            .frame(width: 15)
                        Text(symbol.name)
                            .textSelection(.enabled)
                    }
                }
            }
            .navigationTitle("SF Symbols")
            .navigationViewStyle(.stack)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        // Category filter action
                        isPresented.toggle()
                    } label: {
                        if selectedCategory != nil {
                            Image(systemName: "line.3.horizontal.decrease.circle.fill")
                        } else {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                        }
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
    var categorySymbolName: String
    var isSelected: Bool
    
    var body: some View {
        HStack {
            Image(systemName: categorySymbolName)
                .frame(width: 30)
            Spacer()
                .frame(width: 15)
            Text(categoryName)
            Spacer()
            if isSelected {
                Image(systemName: "checkmark")
                    .foregroundColor(.accentColor)
            }
        }
        // https://swiswiswift.com/2021-04-07/
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
                        categorySymbolName: "square.grid.2x2",
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
                            categorySymbolName: category.symbolName(),
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
                        dismiss()
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
    @State static var category: SFSymbolsCategory? = nil
    
    static var previews: some View {
        Group {
            SymbolsListView()
            CategorySelectionView(category: $category)
        }
    }
}
