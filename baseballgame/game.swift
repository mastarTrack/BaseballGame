//
//  play.swift
//  baseballgame
//
//  Created by 손영빈 on 1/13/26.
//

import Foundation

// 게임 시작 함수
func play() -> Int {
    
//    let result = randomAnswer()
    let result = randomAnswer2()
    var totalCount = 0
    while true {
        /* (Lv.2) 1. 정답 맞추기 + 힌트 받기 */
        print("숫자를 입력하세요: ", terminator: "\n")
        guard let input = readLine(),
              let num = Optional(input.map{Int(String($0))}), //숫자 외의 다른 값이 들어왔는지 확인, map 대신 compactMap 사용 : map -> 이후 nil 처리 필요
              num.count == 3
        else {
            print("올바르지 않은 입력값입니다.")
            continue
        }
        
        if Set(num).count != 3 { //중복된 값이 있는지 확인
            print("올바르지 않은 입력값입니다.(중복)")
            continue
        }
        
        totalCount += 1 //기록 저장용 Count + 1
        
        let inputChars = Array(input) //입력받은 값을 배열에 담음
        
        /* (Lv.2) 2. 힌트 생성, 게산 */
        var strike: Int = 0
        var ball: Int = 0
        
        for i in 0..<3 {
            if result[i] == Int(String(inputChars[i]))! { //Int는 Character를 바로 받지 못함 -> String으로 감싸기
                strike += 1
            } else if result.contains(Int(String(inputChars[i]))!) {
                ball += 1
            }
        }
        if strike == 3 {
            print("정답입니다.")
            return totalCount//정답일 경우, 게임 종료 -> (break를 사용하지 않고 return을 사용한 이유 -> 기록을 남기기 위해서)
        }else if strike >= 1 && ball >= 1 {
            print("\(strike)스트라이크 \(ball)볼")
        }else if strike >= 1 {
            print("\(strike)스트라이크")
        }else if ball >= 1 {
            print("\(ball)볼")
        }else {
            print("Nothing")
        }
        
    }
}
