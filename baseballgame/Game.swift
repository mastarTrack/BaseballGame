//
//  Game.swift
//  aa
//
//  Created by 손영빈 on 1/15/26.
//

// Game 소스코드는 GameRule, GameInput의 객체를 이용하여 게임 내부에서 동작하는 기능들을 구현하는 객체를 만들었습니다. GameRule에서 계산한 힌트 정보를 hint 함수를 통해서 출력하도록 구현했습니다. 또한, 정답을 맞췄을 경우도 hint 함수 내부에서 동작하도록 구현할 수 있으나, 정답일 경우만 play 함수에 넣어둔 이유는 hint 함수는 함수명 그 자체로 힌트만을 출력하는 함수를 구현하고자 생각하여 분리하였습니다.
import Foundation

class Game{
    private let rule = GameRule()
    private let gameinput = GameInput()
    
    func play() -> Int{
        rule.randomAnswer2()
        var totalCount = 0
        
        while true {
            guard let inputNumber = gameinput.getInput() else {
                continue
            }
            
            totalCount += 1 //기록 저장용 Count + 1
            
            let score = rule.gameScore(inputChars: inputNumber)
            
            if score.strike == 3 {
                print("정답입니다.")
                return totalCount
            } else {
                hint(strike : score.strike, ball: score.ball)
            }
        }
    }
    /* (Lv.2) 3. 힌트 출력 */
    func hint(strike: Int, ball: Int){
        if strike >= 1 && ball >= 1 {
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
