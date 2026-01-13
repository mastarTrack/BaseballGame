//
//  FuncCalculate.swift
//  Baseball
//
//  Created by Hanjuheon on 1/13/26.
//

// 중복없이 1~9까지의 숫자를 3자리숫자로 조합 함수
func randomForBaseball()-> [Int]{
    var numbers = [1,2,3,4,5,6,7,8,9]
    var randomNumber: [Int] = []
    
    for _ in 0...2{
        randomNumber.append(numbers.remove(at: Int.random(in: 0..<numbers.count)))
    }

    return randomNumber
}


