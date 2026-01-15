//
//  FuncCalculate.swift
//  Baseball
//
//  Created by Hanjuheon on 1/13/26.
//

/// 중복없이 1~9까지의 숫자를 3자리숫자로 조합 함수
func randomForBaseball() -> [Int]{
    
    // 구 코드
//    var numbers = [1,2,3,4,5,6,7,8,9]
//    var randomNumber: [Int] = []
//    randomNumber.append(numbers.remove(at: Int.random(in: 0..<numbers.count)))
//    numbers.append(0)
//    for _ in 0...1{
//        randomNumber.append(numbers.remove(at: Int.random(in: 0..<numbers.count)))
//    }

    let first = Int.random(in: 1...9)
    var arr = Array((0...9).filter{ $0 != first }.shuffled().prefix(2))
    arr.insert(first, at: 0)
    return arr
}



/// Strike, Bool 판별 함수
func checkStrikeAndBall(target: [Int], guess: [Int]) -> (Int,Int){
    
    var strike = 0
    var bool = 0
    
    // 구 코드
//    // 스트라이크 체크
//    for i in 0...2{
//        if target[i] == guess[i]{
//            strike += 1
//        }
//    }
//    
//    // 볼 체크
//    for i in 0...2{
//        for j in 0...2{
//            if target[i] == guess[j]{
//                bool += 1
//            }
//        }
//    }
    
    for i in 0...2{
        var value = target.filter{ guess.contains( $0 ) }.map{ $0 }
        bool = value.count
        strike = value.filter{ target.firstIndex(of: $0) == guess.firstIndex(of: $0) }.count
    }
    
        
    return (strike, bool - strike)
}
