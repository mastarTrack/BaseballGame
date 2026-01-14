//
//  FuncCalculate.swift
//  Baseball
//
//  Created by Hanjuheon on 1/13/26.
//

/// 중복없이 1~9까지의 숫자를 3자리숫자로 조합 함수
func randomForBaseball() -> [Int]{
    var numbers = [1,2,3,4,5,6,7,8,9]
    var randomNumber: [Int] = []
    
    randomNumber.append(numbers.remove(at: Int.random(in: 0..<numbers.count)))
    numbers.append(0)
    for _ in 0...1{
        randomNumber.append(numbers.remove(at: Int.random(in: 0..<numbers.count)))
    }

    return randomNumber
}

/// 입력된 값이 조건에 충족하는지 판별하기 위한 함수
func checkInputData(_ numbers: String) throws -> [Int]{
    
    // 입력값에 문자있는지 확인
    if !numbers.allSatisfy({$0.isNumber}){
        throw ErrorDuplicate.IsNotNumber
    }
    
    let checkNumber = numbers.compactMap{ Int(String($0)) }
    
    // 입력된 숫자가 3자리 수인지 확인
    if checkNumber.count != 3{
        throw ErrorDuplicate.InvalidNumberCount
    }

    // 중복된 숫자 체크
    if Set(checkNumber).count != 3{
        throw ErrorDuplicate.IsDuplicate
    }
        
    return checkNumber
}

/// Strike, Bool 판별 함수
func checkStrikeAndBall(target: [Int], guess: [Int]) -> (Int,Int){
    
    var strike = 0
    var bool = 0
    
    // 스트라이크 체크
    for i in 0...2{
        if target[i] == guess[i]{
            strike += 1
        }
    }
    
    // 볼 체크
    for i in 0...2{
        for j in 0...2{
            if target[i] == guess[j]{
                bool += 1
            }
        }
    }
        
    return (strike, bool - strike)
}
