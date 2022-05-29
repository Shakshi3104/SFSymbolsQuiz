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
    @State var isSummaryPresented = false
    @Binding var isActive: Bool
    
    var body: some View {
        List {
            Section("What's SF Symbol name?") {
                HStack {
                    Spacer()
                    Image(systemName: quizManager.currentQuiz.question.name)
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
                ForEach(quizManager.currentQuiz.choices, id: \.self) { choice in
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
        }
        // Navigation View
        .navigationTitle("Q. \(quizManager.currentQuizNumber)")
        .navigationBarTitleDisplayMode(.inline)
        // MARK: - Alert
        .alert(quizManager.currentQuiz.isCorret ? "🎉 Correct!" : "💦 Wrong",
               isPresented: $isPresented) {
            Button {
                // prepare next question
                quizManager.prepareQuestion()
                isPresented = false
                
                if quizManager.isFinished {
                    isSummaryPresented = true
                }
            } label: {
                if quizManager.currentQuizNumber >= quizManager.quizCount {
                    Text("Finish")
                } else {
                    Text("Next")
                }
            }
        } message: {
            VStack {
                if quizManager.currentQuiz.isCorret {
                    Text("Correct rate: \(quizManager.correctCount) / \(quizManager.quizCount)")
                } else {
                    Text("Answer: \(quizManager.currentQuiz.question.name)\nCorrect rate: \(quizManager.correctCount) / \(quizManager.quizCount)")
                }
            }
        }
        // MARK: - Summary Sheet
        .sheet(isPresented: $isSummaryPresented) {
            // After dismissed the sheet
            isActive = false
        } content: {
            QuizSummaryView(quizManager: quizManager)
        }
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
