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
    
    @State private var questionCountSelection = 5
    private let questionCounts = [5, 10, 20, 50, 100, 200, 1000]
    
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
                            quizManager.generateQuestions(questionNumber: questionCountSelection)
                            quizManager.prepareQuestion()
                            
                            isActive = true
                        } label: {
                            Text("Start")
                        }
                    }
                }
                
                Section("Setting") {
                    Picker(selection: $questionCountSelection) {
                        ForEach(questionCounts, id: \.self) { questionCount in
                            Text("\(questionCount)")
                        }
                    } label: {
                        Text("Number of questions")
                    }
                    .pickerStyle(.automatic)
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
