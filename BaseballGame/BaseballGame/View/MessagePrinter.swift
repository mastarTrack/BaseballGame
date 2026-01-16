//
//  MessagePrinter.swift
//  BaseballGame
//
//  Created by 변예린 on 1/16/26.
//

import Foundation

class MessagePrinter {
    func welcome() {
        print(GameMessage.welcome)
        print(GameMessage.menu)
    }
    
    func startGame() {
        print(GameMessage.startGame)
    }
    
    func endGame() {
        print(GameMessage.endGame)
    }
    
    func showRecordTitle() {
        print(GameMessage.recordTitle)
    }
    
    func noRecord() {
        print(GameMessage.noRecord)
    }
    
    func error(_ error: InputResult) {
        switch error {
        case .invalid(.menu):
            print(GameMessage.invalidInput, "\n")
            print(GameMessage.selectMenuExample)
            print(GameMessage.menu)
        case .invalid(.answer):
            print(GameMessage.invalidInput, "\n")
            print(GameMessage.userAnswerExample)
        case .duplicate:
            print(GameMessage.duplicateInput, "\n")
            print(GameMessage.userAnswerExample)
        case .valid: break
        }
    }
    
    func result(_ result: CheckResult) {
        if result.correct {
            print(GameMessage.correct)
        } else if result.strike == 0 && result.ball == 0 {
            print(GameMessage.nothing)
        } else {
            print(GameMessage.getHint(for: result.strike, result.ball))
        }
    }
}
