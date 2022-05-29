//
//  QuizSummaryView.swift
//  SFSymbolsQuiz
//
//  Created by MacBook Pro M1 on 2022/05/06.
//

import SwiftUI

struct QuizSummaryView: View {
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var quizManager: SFSymbolsQuizManager
    
    var body: some View {
        NavigationView {
            List {
                Section("Score") {
                    VStack {
                        HStack {
                            Spacer()
                            Text("\(quizManager.correctCount) / \(quizManager.quizCount)")
                                .font(.system(.title2, design: .rounded).monospacedDigit())
                            Spacer()
                        }
                        .padding(5)
                        
                        HStack {
                            Spacer()
                            Text("Correct rate")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                    }
                    .padding(5)
                }
                
                Section("Asked") {
                    ForEach(quizManager.quiz, id: \.self) { question in
                        HStack {
                            Image(systemName: question.question.name)
                                .frame(width: 30)
                            Spacer()
                                .frame(width: 15)
                            Text(question.question.name)
                            Spacer()
                            Text(question.isCorret ? "🎉" : "💦")
                        }
                    }
                }
            }
            .navigationTitle("Summary")
            .navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(.stack)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Done")
                    }
                    
                }
            }
        }
    }
}

struct QuizSummaryView_Previews: PreviewProvider {
    @ObservedObject static var quizManager = SFSymbolsQuizManager()
    
    static var previews: some View {
        QuizSummaryView(quizManager: quizManager)
            .onAppear {
                quizManager.generateQuestions()
                quizManager.prepareQuestion()
            }
    }
}
