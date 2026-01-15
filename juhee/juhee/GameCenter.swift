//
//  GameCenter.swift
//  juhee
//
//  Created by 김주희 on 1/14/26.
//

import Foundation

class GameCenter { // 게임에 필요한 계산을 하는 클래스
    
    
    // 사용자가 입력한 값 검증
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
    
    // 입력값과 정답을 계산하는 함수
    func compareInput(_ number: Int, _ ansArray: Array<Int>) -> String {
        var strike = 0
        var ball = 0
        
        let inputArray = splitNum(number) // 입력값을 쪼개서 세 원소를 가진 배열로

        // strike, ball에 값 입력
        for i in 0..<3 {
            if inputArray[i] == ansArray[i] {
                strike += 1
            } else if ansArray.contains(inputArray[i]){
                ball += 1
            }
        }
        
        if (strike == 3 && ball == 0) {
            print("정답입니다!")
            return "정답"
        } else if (strike == 0 && ball == 0){
            print("Nothing")
            return "False"
        } else {
            print("\(strike)스트라이크 \(ball)볼\n ")
            return "False"
        }
        
    }
    
    // 정답 만드는 함수
    func makeAnswer() -> Array<Int> {
        var answerSet: Set<Int> = []
        answerSet.insert(Int.random(in: 1...9)) // 일의 자리 수는 1부터 9까지

        while answerSet.count < 3 { // Set을 이용한 중복없이 정답 생성
            answerSet.insert(Int.random(in: 0...9))
        }
        let answerArray = Array(answerSet) // 순서없는 Set을 Array로 변경
        return answerArray
    }
    
    
    // 입력한 세자리 수를 숫자 각 한개씩으로 배열로 쪼개는 함수
    func splitNum(_ num: Int) -> [Int] {
        let a = num / 100
        let b = num / 10 - a * 10
        let c = num % 10
        return [a, b, c]
    }
    
    
}
