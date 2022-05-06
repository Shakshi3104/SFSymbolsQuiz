//
//  SFSymbolsQuizManager.swift
//  SFSymbolsQuiz
//
//  Created by MacBook Pro M1 on 2022/05/04.
//

import Foundation

// MARK: - SF Symbols Question
struct SFSymbolsQuestion {
    let question: SFSymbol
    var choices: [SFSymbol]
    
    init() {
        question = SFSymbol(name: "iphone", categories: [])
        choices = []
    }
    
    init(question: SFSymbol, choices: [SFSymbol]) {
        self.question = question
        self.choices = choices
    }
}

// MARK: - SF Symbols Quiz Manager
class SFSymbolsQuizManager: ObservableObject {
    private var quiz = [SFSymbolsQuestion]()
    
    @Published var currentQuiz = SFSymbolsQuestion()
    @Published var isFinished = false
    
    /// current quiz number
    var currentQuizNumber = 0
    /// number of correct answer
    var correctCount = 0
    /// number of quiz
    var quizCount = 0
    
    var isCorrect = false
    
    private let sfSymbols = SFSymbols()
    
    // generate SF Symbols questions
    func generateQuestions(questionNumber: Int = 20, category: SFSymbolsCategory? = nil) {
        quizCount = questionNumber
        
        let shuffledSFSymbols = sfSymbols.allCases(category: category).shuffled()
        // SF Symbols list for question
        let questionSFSymbols = shuffledSFSymbols.prefix(questionNumber)
        // SF Symbols list for other choices
        let choicesSFSymbols = shuffledSFSymbols.suffix(questionNumber * 3)
        
        // generate questions
        for question in questionSFSymbols {
            // generate choices
            var choices = choicesSFSymbols.choose(3)
            choices.append(question)
            
            quiz.append(SFSymbolsQuestion(question: question,
                                          choices: choices.shuffled()))
        }
    }
    
    func prepareQuestion() {
        if currentQuizNumber >= quiz.count {
            isFinished = true
        } else {
            currentQuiz = quiz[currentQuizNumber]
        }
        
        currentQuizNumber += 1
    }
    
    func judge(selection: SFSymbol) {
        if currentQuiz.question == selection {
            correctCount += 1
            isCorrect = true
            print("🎉 Correct!")
        } else {
            isCorrect = false
        }
    }
    
    // reset SF Symbols questions
    func resetQuestions() {
        quiz = [SFSymbolsQuestion]()
        currentQuizNumber = 0
        correctCount = 0
        isFinished = false
    }
}
