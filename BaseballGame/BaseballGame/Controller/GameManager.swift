//
//  BaseballGameManager.swift
//  BaseballGame
//
//  Created by 변예린 on 1/15/26.
//

import Foundation

class GameManager {
    // 게임 정답 생성 함수
    func setAnswer() -> [Int] {
        return Array((0...9).shuffled() // 숫자 섞기
            .trimmingPrefix(while: { $0 == 0 }) // while 조건에 맞는 첫 글자 삭제
            .prefix(3))
    }

    // 정답 & 유저 입력 비교 함수
    func check(_ user: [Int], with answer: [Int]) -> CheckResult {
        var strike = 0
        var ball = 0
        
        // 힌트 설정(스트라이크, 볼)
        for (i, element) in user.enumerated(){
            if answer[i] == element {
                strike += 1 // 숫자의 자리와 요소가 동일할 경우
            } else if answer.contains(element) {
                ball += 1 // 숫자의 요소가 동일할 경우
            }
        }
        
        let isCorrect = strike == 3 ? true : false // 정답 여부

        return CheckResult(strike: strike, ball: ball, correct: isCorrect)
    }
}
