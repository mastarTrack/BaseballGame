//
//  BaseballGameManager.swift
//  BaseballGame
//
//  Created by 변예린 on 1/15/26.
//

import Foundation

struct BaseballGameManager {
    //TODO: 환영 인사 / 메뉴 문자열 구분 필요
    /// 게임 시작 화면에서 메뉴를 선택하는 함수입니다.
    func selectMenu() -> Menu? {
        while true {
            print(GameMessage.welcome) // 환영 인사
            let input = (readLine() ?? "").trimmingCharacters(in: .whitespacesAndNewlines) // 유저 입력값
            
            if Menu(rawValue: input) != nil {
                return Menu(rawValue: input) // 유효한 입력값일 경우 Menu 타입 반환
            } else {
                print(GameMessage.invalidInput, GameMessage.selectMenuExample) // 에러 메세지 출력
            }
        }
        return nil
    }
    
    //TODO: 반환값 타입 정하기
    // 정답 & 유저 입력 비교 함수
    func checkAnswer(_ user: [Int], with answer: [Int]) -> (strike: Int, ball: Int, correct: Bool) {
        // 힌트 초기화
        var hint: (strike: Int, ball: Int) = (0, 0)
        // 힌트 설정(스트라이크, 볼)
        for (i, element) in user.enumerated(){
            if answer[i] == element {
                hint.strike += 1
            } else if answer.contains(element) {
                hint.ball += 1
            }
        }
        
        let correct = hint.strike == 3 ? true : false

        return (strike: hint.strike, ball: hint.ball, correct: correct)
    }
}
