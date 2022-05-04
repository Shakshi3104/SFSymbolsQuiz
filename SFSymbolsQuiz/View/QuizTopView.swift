//
//  QuizTopView.swift
//  SFSymbolsQuiz
//
//  Created by MacBook Pro M1 on 2022/05/04.
//

import SwiftUI

struct QuizTopView: View {
    @ObservedObject var quizManager = SFSymbolsQuizManager()
    
    @State private var isActive = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ZStack {
                        NavigationLink(isActive: $isActive) {
                            QuizAnswerView(quizManager: quizManager,
                            isActive: $isActive)
                        } label: {
                            EmptyView()
                        }
                        
                        Button {
                            // prepare quiz
                            quizManager.resetQuestions()
                            quizManager.generateQuestions(questionNumber: 20)
                            quizManager.prepareQuestion()
                            
                            isActive = true
                        } label: {
                            Text("Start")
                        }
                    }
                }
                
                Section("Setting") {
                    HStack {
                        Text("Number of questions")
                        Spacer()
                        Text("20")
                    }
                }
            }
            .navigationTitle("SF Symbols Quiz")
        }
    }
}

struct QuizTopView_Previews: PreviewProvider {
    static var previews: some View {
        QuizTopView()
    }
}
