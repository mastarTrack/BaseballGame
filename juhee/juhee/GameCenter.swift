//
//  GameCenter.swift
//  juhee
//
//  Created by 김주희 on 1/14/26.
//

import Foundation

class GameCenter { // 게임에 필요한 계산을 하는 클래스

    
    // MARK: - 입력한 세자리 수를 숫자 각 한개씩으로 배열로 쪼개는 내부 로직 함수
    private func splitNum(_ num: Int) -> [Int] {
        let a = num / 100
        let b = num / 10 - a * 10
        let c = num % 10
        return [a, b, c]
    }
    
    
    // MARK: - 정답 만드는 함수
    func makeAnswer() -> [Int] {
        var answerArray: [Int] = []
        answerArray.append(Int.random(in: 1...9)) // 백의 자리 수는 1부터 9까지

        while answerArray.contains(answerArray[0]) {
            answerArray.append(Int.random(in: 0...9))
        }

        while answerArray.contains(answerArray[0]) || answerArray.contains(answerArray[1]) {
            answerArray.append(Int.random(in: 0...9))
        }

        return answerArray
    }
    
    
    // MARK: - 사용자가 입력한 값 검증 함수
    func checkInput(_ inputNumber: Int) -> Bool {
        let set = Set(splitNum(inputNumber))
        
        if set.count == 3   // Array를 Set으로 변환하여 중복을 제외한 값이 3이어야 함
            && 99 < inputNumber
            && inputNumber < 1000 {
            return true
        } else {
            return false
        }
    }
    
    
    // MARK: - GameResult 구조체
    enum GameResult {
        case correct
        case nothing
        case progress(strike: Int, ball: Int)
    }
    
    
    // MARK: - 입력값과 정답을 비교해 힌트 계산하는 함수
    func compareInpAns(_ number: Int, _ ansArray: [Int]) -> GameResult {
        var strike = 0
        var ball = 0
        let inputArray = splitNum(number) // 입력값을 쪼개서 세 원소를 가진 배열로

        // strike, ball에 결과값 입력
        for i in 0..<3 {
            if inputArray[i] == ansArray[i] {
                strike += 1
            } else if ansArray.contains(inputArray[i]){
                ball += 1
            }
        }
        
        if (strike == 3) {
            return GameResult.correct
        } else if (strike == 0 && ball == 0){
            return GameResult.nothing
        } else {
            return GameResult.progress(strike: strike, ball: ball)
        }
    }
}
