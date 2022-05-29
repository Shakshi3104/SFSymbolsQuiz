//
//  Collection+Extension.swift
//  SFSymbolsQuiz
//
//  Created by MacBook Pro M1 on 2022/05/04.
//

import Foundation

// https://stackoverflow.com/questions/27259332/get-random-elements-from-array-in-swift
extension Collection {
    func choose(_ n: UInt) -> ArraySlice<Element> {
        shuffled().prefix(Int(n))
    }
}
