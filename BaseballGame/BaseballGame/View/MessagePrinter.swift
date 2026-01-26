//
//  MessagePrinter.swift
//  BaseballGame
//
//  Created by 변예린 on 1/16/26.
//

import Foundation

// GameMessage를 출력하는 클래스입니다.
class MessagePrinter {
    func welcome() {
        print(GameMessage.welcome)
        print(GameMessage.menu)
    }
    
    func startGame() {
        print(GameMessage.startGame)
        print(GameMessage.userAnswerExample)
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
    
    func error(_ error: InputError) {
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
        }
    }
    
    func unknownError() {
        print(GameMessage.unknownError)
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
