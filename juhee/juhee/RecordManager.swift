//
//  RecordManager.swift
//  juhee
//
//  Created by 김주희 on 1/13/26.
//

import Foundation

public class RecordManager { // 기록 관리 클래스
    var trial = 0 // 게임 시도 횟수
    var trialCounts: Array<Int> = [] // 시도 횟수 저장할 빈 배열
    
    // 게임 시도 횟수 증가 함수
    func addTrial() {
        trial += 1
    }

    // 배열에 시도 횟수 추가 함수
    func add(_ trialcount: Int) {
        trialCounts.append(trialcount)
    }
    
    // 기록 출력 함수
    func showRecords() {
        for (idx, value) in trialCounts.enumerated() {
            print("\(idx + 1)번째 게임: 시도 횟수 - \(value)")
        }
    }
    
}
