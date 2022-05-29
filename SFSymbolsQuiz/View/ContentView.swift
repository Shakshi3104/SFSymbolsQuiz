//
//  ContentView.swift
//  SFSymbolsQuiz
//
//  Created by MacBook Pro M1 on 2022/05/02.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            QuizView()
            .tabItem {
                Label("Quiz", systemImage: "questionmark.circle")
            }
            
            SymbolsListView()
                .tabItem {
                    Label("List", systemImage: "list.bullet.circle")
                }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
