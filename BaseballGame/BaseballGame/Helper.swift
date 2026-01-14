//
//  Error.swift
//  BaseballGame
//
//  Created by 변예린 on 1/13/26.
//

import Foundation

enum SystemMessage {
    case welcome
    case gameStart
    
    case selectMenuExample
    case userAnswerExample
    
    case invalidInput
    case duplicateInput
    
    case hint(strike: Int, ball: Int)
}

extension SystemMessage: CustomStringConvertible {
    var description: String {
        switch self {
        case .welcome:
            return """
            환영합니다! 원하시는 번호를 입력해주세요. (예: 1)
            1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기
            """
        case .gameStart:
            return "\n❮ 게임을 시작합니다. ❯"
        case .selectMenuExample:
            return "실행을 원하는 메뉴의 숫자를 입력해주세요. (예: 1)"
        case .userAnswerExample:
            return "서로 다른 3자리 숫자를 입력해주세요. (예: 123)"
        case .invalidInput:
            return "⚠️ 유효하지 않은 입력입니다."
        case .duplicateInput:
            return "⚠️ 중복 숫자 입력입니다."
        case .hint(let s, let b):
            return s == 3 ? "🎉 정답입니다! 🎉"
            : s == 0 && b == 0 ? "❌ Nothing\n" :
            "🎯 \(s) 스트라이크 ⚾️ \(b) 볼 입니다!\n"
        }
    }
}

enum Menu: String {
    case play = "1", record = "2", exit = "3"
}
