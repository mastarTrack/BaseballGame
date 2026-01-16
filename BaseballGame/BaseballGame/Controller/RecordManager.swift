//
//  RecordManager.swift
//  BaseballGame
//
//  Created by 변예린 on 1/16/26.
//

import Foundation

class RecordManager {
    static let shared = RecordManager()
    private var record = Record()
    
    private init() {}
    
    // 게임 플레이 횟수 증가
    func addRound() {
        // - round 기본값은 0, round는 attempts 배열의 인덱스로 사용됨: attempts[round]
        // - 기본값이 attempts 배열보다 앞서있으므로 배열이 비어있을 때는 round를 증가시키지 않음
        // --> round를 증가시킬 경우, 시도 횟수는 attempts[0]에 저장되지만 round == 1이므로 attempts[round]로 조회 불가능
        record.round = record.attempts.isEmpty ? record.round : +1
        record.attempts.append(0) // record.attempts 배열 확장
    }
    
    // 게임 시도 횟수 증가
    func addAttempt() {
        record.attempts[record.round] += 1
    }
    
    // 기록 초기화
    func resetRecord() {
        record.round = 0
        record.attempts = []
    }
    
    // 기록 전달
    func fetchRecord() -> Record {
        return record
    }
}
