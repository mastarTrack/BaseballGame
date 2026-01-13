//
//  BaseballGame.swift
//  juhee
//
//  Created by 김주희 on 1/13/26.
//

import Foundation

class BaseballGame {
    func start() {
        let answer = makeAnswer() // 정답 만드는 함수
        print("<게임을 시작합니다>")
        
        while true {
            
            // 1. 유저에게 입력값 받기
            print("숫자를 입력하세요")
            guard let input = readLine(),
                  let inputNumber = Int(input), // 숫자로 변환
                checkInput(inputNumber) // 입력값 검사 함수 호출
            else {
                print("올바르지 않은 입력값입니다.")
                continue // 다시 입력하도록 while문 다시 실행
            }
            
            if compareInput(inputNumber, answer) == false { // 정답이면 false 출력하고 반복문에서 빠져나감
                break
            }
        }
    }
    
    func checkInput(_ inputNumber: Int) -> Bool {
        var checkNum = inputNumber
        let a = checkNum / 100
        checkNum -= a * 100
        
        let b = checkNum / 10
        checkNum -= b * 10
        
        let c = checkNum
        
        if a != b && b != c && c != a && 99 < inputNumber && inputNumber < 1000 {
            return true
        } else {
            return false
        }
        
    }
    
    // 입력값과 정답을 계산하는 함수
    func compareInput(_ number: Int, _ ansArray: Array<Int>) -> Bool {
        var compareNum = number
        var strike = 0
        var ball = 0
        
        let a = compareNum / 100
        compareNum -= a * 100
        
        let b = compareNum / 10
        compareNum -= b * 10
        
        let c = compareNum
        
        let inputArray = [a, b, c]
        
        for (ansIdx, ansEle) in ansArray.enumerated(){
            for (iptIdx, iptEle) in inputArray.enumerated() {
                if ansEle == iptEle { // 두 값이 같을때
                    if ansIdx == iptIdx { // 인덱스 값도 같을때
                        strike += 1
                    } else {
                        ball += 1
                    }
                }
            }
        }
        if (strike == 3 && ball == 0) {
            print("정답입니다!")
            return false
        } else if (strike == 0 && ball == 0){
            print("Nothing")
            return true
        } else {
            print("\(strike)스트라이크 \(ball)볼")
            return true
        }
        
    }
    
    
    // LV. 1
    // 1에서 9까지의 서로 다른 임의의 정답인 수 3개를 정하기 (abc)
    func makeAnswer() -> Array<Int> {
                
        let a = Int.random(in: (1...9))
        
        var b = Int.random(in: 1...9)
        while a == b {
            b = Int.random(in: 1...9) // a와 b가 다를때까지 b에 랜덤한 Int값 대입
        }
        
        var c = Int.random(in: 1...9)
        while a == c || b == c {
            c = Int.random(in: 1...9) // c가 a, b값과 다를때까지 c에 랜덤한 Int값 대입
        }
        
        let answer: Array = [a, b, c]
        return answer
    }
}
