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
        let arr = splitNum(inputNumber)
        
        nthTrial += 1 // 정답 맞추기 위한 시도 횟수 1 증가
        
        if arr[0] != arr[1]
            && arr[1] != arr[2]
            && arr[0] != arr[2]
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
        
        let inputArray = splitNum(number) // 입력값을 쪼개서 세원소를 가진 배열로
        
        // strike,ball에 값 입력
        for i in 0..<3 {
            if inputArray[i] == ansArray[i] {
                strike += 1
            } else if ansArray.contains(inputArray[i]) {
                ball += 1
            }
        }
        
        if (strike == 3 && ball == 0) {
            print("정답입니다!")
            return "True"
        } else if (strike == 0 && ball == 0){
            print("Nothing")
            return "False"
        } else {
            print("\(strike)스트라이크 \(ball)볼\n ")
            return "False"
        }
        
    }
    
    // 정답 만드는 함수
    // 1에서 9까지의 서로 다른 임의의 정답인 수 3개를 정하기 (abc)
    func makeAnswer() -> Array<Int> {
                
        let a = Int.random(in: (1...9))
        
        var b = Int.random(in: 0...9)
        while a == b {
            b = Int.random(in: 0...9) // a와 b가 다를때까지 b에 랜덤한 Int값 대입
        }
        
        var c = Int.random(in: 0...9)
        while a == c || b == c {
            c = Int.random(in: 0...9) // c가 a, b값과 다를때까지 c에 랜덤한 Int값 대입
        }
        
        let answer: Array = [a, b, c]
        return answer
    }
    
    
    // 입력한 세자리 수를 숫자 각 한개씩으로 배열로 쪼개는 함수
    func splitNum(_ num: Int) -> [Int] {
        let a = num / 100
        let b = num / 10
        let c = num % 10
        return [a, b, c]
    }
    
    
}
