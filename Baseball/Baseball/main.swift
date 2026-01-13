//
//  main.swift
//  Baseball
//
//  Created by Hanjuheon on 1/13/26.
//

import Foundation

var computer: Computer = Computer()
var user:User = User(name: "")
var input: String? = ""
var userBallNum: [Int] = []
var checkResult: (Int,Int)

print("사용자 정보를 확인하겠습니다.")
print("사용자 아이디를 입력해주세요(영문권장)")
user.setName(readLine()!)
print("\(user.getName())님 안녕하세요. 게임을 시작전 룰을 설명드리겠습니다.")

// 게임 룰 설명
print(GameMessages.gameRule.rawValue)

// 게임 시작 안내
print(GameMessages.gameStart.rawValue)
computer.setNumber(randomForBaseball())

while false{
    sleep(1)
    print(GameMessages.inputNumber.rawValue)
    do {
        userBallNum = try checkInputData(readLine()!)
    }catch ErrorDuplicate.IsNotNumber{
        print(GameMessages.notNumber.rawValue)
        continue
    }catch ErrorDuplicate.InvalidNumberCount{
        print(GameMessages.invalidCount.rawValue)
        continue
    }catch ErrorDuplicate.IsDuplicate{
        print(GameMessages.duplicate.rawValue)
        continue
    }
    
    checkResult = CheckStrikeAndBall(target: computer.getNumber(), guess:userBallNum)
    
    if checkResult.0 == 3{
        print(GameMessages.correct.rawValue)
        break
    }
    else if checkResult.0 == 0 && checkResult.1 == 0{
        print(GameMessages.nothing.rawValue)
    }
    else{
        print(GameMessages.result(strike: checkResult.0, ball: checkResult.1))
    }
}


