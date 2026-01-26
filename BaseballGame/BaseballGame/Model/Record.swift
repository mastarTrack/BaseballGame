//
//  Record.swift
//  BaseballGame
//
//  Created by 변예린 on 1/16/26.
//

import Foundation

// 게임 기록 클래스입니다. 변동 가능성이 크기 때문에 구조체가 아닌 클래스로 구현하였습니다.
class Record {
    var round = 0
    var attempts: [Int] = []
}
