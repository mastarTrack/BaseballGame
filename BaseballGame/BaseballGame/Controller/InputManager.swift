//
//  InputDesk.swift
//  BaseballGame
//
//  Created by 변예린 on 1/16/26.
//

import Foundation

// 유저에게 값을 입력받고 검증하는 클래스입니다.
class InputManager {
    // 유저로부터 실행할 메뉴를 입력받는 함수
    func inputMenu() throws -> Menu {
        let input = (readLine() ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        
        if let result = Menu(rawValue: input) {
            return result
        } else {
            throw InputError.invalid(for: .menu)
        }
        
    }
    
    // 유저로부터 정답을 입력받는 함수
    func inputUserAnswer() throws -> [Int] {
        // 유저 입력값
        let input = (readLine() ?? "").compactMap{ Int(String($0)) }
        
        if input.count != 3 {
            throw InputError.invalid(for: .answer) // 유저 입력이 3자리 숫자가 아닐 경우
        } else if Set(input).count != 3 {
            throw InputError.duplicate // 유저 입력에 중복 숫자가 있을 경우
        } else {
            return input //정상 입력일 경우
        }
    }    
}
