//
//  GameMessage.swift
//  BaseballGame
//
//  Created by 변예린 on 1/15/26.
//

import Foundation

enum GameMessage {
    static let welcome = "환영합니다! 원하시는 메뉴를 입력해주세요. (예: 1)"
    static let menu = "1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기"
    
    static let startGame = "\n❮ 게임을 시작합니다. ❯"
    static let endGame = "❮ 숫자 야구 게임을 종료합니다. ❯"
    
    static let recordTitle = "❮게임 기록 보기❯\n"
    static let noRecord = "플레이한 게임 기록이 없습니다!\n"
    
    static let selectMenuExample = "실행을 원하는 메뉴의 숫자를 입력해주세요. (예: 1)"
    static let userAnswerExample = "서로 다른 3자리 숫자를 입력해주세요. (예: 123)"
    
    static let invalidInput = "⚠️ 유효하지 않은 입력입니다."
    static let duplicateInput = "⚠️ 중복 숫자 입력입니다."
    static let unknownError = "⚠️ 알 수 없는 오류입니다."
    
    static let correct = "🎉 정답입니다! 🎉\n"
    static let nothing = "❌ Nothing\n"
     
    static func getHint(for strike: Int, _ ball: Int) -> String {
        return "🎯 \(strike) 스트라이크 ⚾️ \(ball) 볼 입니다!\n"
    }
    
    static func getRecord(for game: Int, attempt: Int) -> String {
        return "\(game + 1)번째 게임: 시도 횟수 - \(attempt)"
    }
}
