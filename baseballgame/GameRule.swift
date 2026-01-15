//
//  GameRule.swift
//  aa
//
//  Created by 손영빈 on 1/15/26.
//


// GameRule 소스코드는 게임의 규칙을 생성하기 위한 객체를 만들었습니다. 때문에, 기존에 합쳐져있던 힌트의 생성과 출력은 분리하여 본 파일에서는 힌트 결과 생성만을 구현합니다.
import Foundation

class GameRule {
    private var result: [Int] = []
    
    /* (Lv.1) 1. 1~9 서로 다른 난수 3개 생성 -> Set 사용 -> 문제점 : 정답 생성용 Set, 저장용 Array 별도로 필요*/
    func randomAnswer(){
        var answer: Set<Int> = []
        var result: [Int] = []

        while answer.count < 3 { //정답 생성용(Set 사용) : 같은 수 반복 x
            let num = Int.random(in: 1...9)
            answer.insert(num)
        }
        result = Array(answer) // 정답 저장용
    //    print(answer)
    //    print(result)
        self.result = result // 변경사항 -> return 사용하지않고 객체에 result로 담아둠
    }
    
    /* (Lv 3.) 1. 첫 자리(1~9), 나머지(0~9): Set 사용하지 않고 contains로 조건 사용 */
    func randomAnswer2(){
        var result: [Int] = []
        
        let fst = Int.random(in: 1...9)
        result.append(fst)
        while result.count < 3{
            let rndnum = Int.random(in: 0...9)
            if !result.contains(rndnum){
                result.append(rndnum)
            }
        }
        //    print(result)
        self.result = result // 변경사항 -> return 사용하지않고 객체에 result로 담아둠
    }
    
    /* (Lv.2) 2. 힌트 생성, 계산 -> 출력은 game.hint를 이용하여 사용하도록 분리 */
    func gameScore(inputChars: [Int]) -> (strike: Int, ball: Int){
        var strike: Int = 0
        var ball: Int = 0
        
        for i in 0..<3 {
            if result[i] == inputChars[i] { // 변경사항 -> inputChars는 배열이라 inputChars[i]로 접근 가능
                strike += 1
            } else if result.contains(inputChars[i]) {
                ball += 1
            }
        }
        return (strike, ball)
    }
}
