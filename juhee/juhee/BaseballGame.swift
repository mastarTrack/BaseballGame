//
//  BaseballGame.swift
//  juhee
//
//  Created by 김주희 on 1/13/26.
//

import Foundation

class BaseballGame {
    func start() {
        let answer = makeAnswer()
        print(answer)
    }
    
    // 1에서 9까지의 서로 다른 임의의 수 3개를 정하기 (abc)
    func makeAnswer() -> Int {

        let a = Int.random(in: (1...9))
        var returnAnswer = a * 100 // 백의자리 숫자 a 대입
        
        var b = Int.random(in: 1...9)
        while a == b {
            b = Int.random(in: 1...9)
        }
        returnAnswer += b * 10      // 십의 자리 숫자 b 대입
        
        var c = Int.random(in: 1...9)
        while a == c || b == c {
            c = Int.random(in: 1...9)
        }
        returnAnswer += c           // 일의 자리 숫자 c 대입

        return returnAnswer
    }
    
    
}

