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

print("\(user.getName())님 안녕하세요. 게임을 시작하겠습니다.")

