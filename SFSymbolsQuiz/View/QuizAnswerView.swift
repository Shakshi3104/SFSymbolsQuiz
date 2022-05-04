//
//  QuizAnswerView.swift
//  SFSymbolsQuiz
//
//  Created by MacBook Pro M1 on 2022/05/04.
//

import SwiftUI

struct QuizAnswerView: View {
    @ObservedObject var quizManager: SFSymbolsQuizManager
    
    @State var isPresented = false
    @Binding var isActive: Bool
    
    var body: some View {
        List {
            Section("What's SF Symbol name?") {
                HStack {
                    Spacer()
                    Image(systemName: quizManager.presentQuiz.question.name)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80,
                               height: 80,
                               alignment: .center)
                        .foregroundColor(.accentColor)
                    Spacer()
                }
                .padding(30)
            }
            
            Section("Choices") {
                ForEach(quizManager.presentQuiz.choices, id: \.self) { choice in
                    HStack {
                        Text(choice.name)
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        isPresented = true
                        // judge the answer
                        quizManager.judge(selection: choice)
                    }
                }
            }
            .alert(quizManager.isCorrect ? "🎉 Correct!" : "💦 Wrong",
                   isPresented: $isPresented) {
                Button {
                    // prepare next question
                    quizManager.prepareQuestion()
                    isPresented = false
                    
                    // finish quiz
                    if quizManager.isFinished {
                        isActive = false
                        quizManager.resetQuestions()
                    }
                } label: {
                    if quizManager.quizNumber >= quizManager.quiz.count {
                        Text("Finish")
                    } else {
                        Text("Next")
                    }
                }
            } message: {
                VStack {
                    if quizManager.isCorrect {
                        Text("Correct rate: \(quizManager.correctCount) / \(quizManager.quiz.count)")
                    } else {
                        Text("Answer: \(quizManager.presentQuiz.question.name)\nCorrect rate: \(quizManager.correctCount) / \(quizManager.quiz.count)")
                    }
                }
            }
        }
        .navigationTitle("Q. \(quizManager.quizNumber)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct QuizAnswerView_Previews: PreviewProvider {
    @ObservedObject static var quizManager = SFSymbolsQuizManager()
    
    static var previews: some View {
        QuizAnswerView(quizManager: quizManager, isActive: .constant(true))
            .onAppear {
                quizManager.generateQuestions()
                quizManager.prepareQuestion()
            }
    }
}
