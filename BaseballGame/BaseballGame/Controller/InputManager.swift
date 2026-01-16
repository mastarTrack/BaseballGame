//
//  InputDesk.swift
//  BaseballGame
//
//  Created by 변예린 on 1/16/26.
//

import Foundation

class InputManager {
    // 유저로부터 실행할 메뉴를 입력받는 함수
    func inputMenu() -> Menu? {
        let input = (readLine() ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        return Menu(rawValue: input)
    }
    
    // 유저로부터 정답을 입력받는 함수
    func inputUserAnswer() -> [Int] {
        // 유저 입력값
        let input = (readLine() ?? "").compactMap{ Int(String($0)) }
        return input
    }
    
    func verify(_ input: [Int]) -> InputResult {
        if input.count != 3 {
            return .invalid(for: .answer) // 유저 입력이 3자리 숫자가 아닐 경우
        } else if Set(input).count != 3 {
            return .duplicate // 유저 입력에 중복 숫자가 있을 경우
        } else {
            return .valid // 정상 입력일 경우
        }
    }
}
