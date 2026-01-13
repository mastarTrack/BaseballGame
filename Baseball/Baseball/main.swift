//
//  main.swift
//  Baseball
//
//  Created by Hanjuheon on 1/13/26.
//

import Foundation

print("사용자 정보를 확인하겠습니다.")
print("이름:", separator: "")

let input = readLine()
var user:User = User(name: input!)

print("\(user.getName())님 안녕하세요. 게임을 시작전 룰을 설명드리겠습니다.")
// 게임 룰 설명
print("""
게임 설명.
- 컴퓨터는 게임시작과 동시에 중복숫자가 없는 랜덤 3자리 숫자를 부여받습니다.
- \(user.getName())은 중복없는 숫자 3자리를 입력하여 정확히 맞추는 게임입니다.
- 정확히 맞추지 못할 시에는 컴퓨터 숫자에 대한 힌트가 공유됩니다.
- 숫자와 자릿수를 모두 맞추었을 경우 Strike 카운트가 올라갑니다.
- 숫자만 맞추셨을 경우 Ball 카운트가 올라갑니다.
- 컴퓨터의 숫자를 모두 맞추어 3 Strike가 되면 플레이어 우승으로 게임이 종료됩니다.
- 만약 중간에 포기를 원하시는 경우 "Q"를 입력해 주세요.
""")

// 게임 시작 안내
print("게임을 시작겠습니다. 컴퓨터 숫자 배치중...")
var computer: Computer = Computer()
computer.setNumber(randomForBaseball())




