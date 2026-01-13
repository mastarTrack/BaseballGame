//
//  Game.swift
//  BaseballGame
//
//  Created by 변예린 on 1/13/26.
//

import Foundation

class BaseballGame {
    var answer: [Int] = []
    var userAnswer: [Int] = []
    
    var isCorrect = false
    var hint: (strike: Int, ball: Int) = (0, 0)
    
    // 게임 시작 함수
    func play() {
        setAnswer() // 정답 생성
        
        // 정답을 맞힐 때까지 반복
        while !isCorrect {
            do {
                try getUserAnswer()
                checkAnswer()
            } catch GameError.invalidInput {
                print("유효하지 않은 입력입니다!")
            } catch {
                print("알 수 없는 오류입니다.")
            }
        }
    }
    
    // 정답 생성 함수
    func setAnswer() {
        for _ in 0...2 {
            if !answer.isEmpty {
                var num = Int.random(in: 1...9)
                
                while answer.contains(num) { // 정답에 포함되어있다면 num 재생성
                    num = Int.random(in: 1...9)
                }
                answer.append(num)
            } else {
                answer.append(Int.random(in: 1...9))
            }
        }
        print("정답: \(answer)")
    }
    
    // 유저 정답 입력 함수
    func getUserAnswer() throws {
        print("3자리 숫자를 입력해주세요. (예: 123)")
        
        // 유저 입력
        guard let input = readLine() else {
            throw GameError.invalidInput
        }
        
        // 공백 삭제
        let stringNum = input.replacingOccurrences(of: " ", with: "")
        
        // 유저 입력 배열
        userAnswer = stringNum.compactMap{ Int(String($0)) }
        
        // 유저 입력이 3자리 숫자가 아닐 경우의 예외 처리
        guard userAnswer.count == 3 else {
            throw GameError.invalidInput
        }
    }
    
    // 정답 & 유저 입력 비교 함수
    func checkAnswer() {
        // 힌트 초기화
        hint.strike = 0
        hint.ball = 0
        
        // 오류 시 무시
        guard userAnswer.count == 3 else { return }
        
        // 스트라이크, 볼 확인
        userAnswer.enumerated().forEach {
            if answer[$0.offset] == $0.element {
                hint.strike += 1
            } else if answer.contains($0.element) {
                hint.ball += 1
            }
        }
        
        // 힌트에 따른 분기 처리
        if hint.strike == 3 {
            isCorrect = true
            print("정답입니다!")
        } else if hint.strike == 0 && hint.ball == 0 {
            print("Nothing")
        } else {
            print("\(hint.strike) 스트라이크 \(hint.ball) 볼 입니다!")
        }
    }
}
