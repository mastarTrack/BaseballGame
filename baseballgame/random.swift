//
//  random.swift
//  baseballgame
//
//  Created by 손영빈 on 1/13/26.
//

import Foundation

// 3자리 난수 생성 함수(1~9) -> Set 사용 -> 문제점 : 정답 생성용 Set, 정답 저장용 Array가 별도로 필요함.
func randomAnswer() -> [Int] {
    var answer: Set<Int> = []
    var result: [Int] = []

    /* (Lv.1) 1. 1~9 서로 다른 난수 3개 생성 */
    while answer.count < 3 { //정답 생성용(Set 사용) : 같은 수 반복 x
        let num = Int.random(in: 1...9)
        answer.insert(num)
    }
    result = Array(answer) // 정답 저장용
//    print(answer)
//    print(result)
    return result
}
/* (Lv 3.) 1. 첫 자리(1~9), 나머지(0~9): Set 사용하지 않고 contains로 조건 사용 */
func randomAnswer2() -> [Int] {
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
    return result
}
