//
//  RecordManager.swift
//  juhee
//
//  Created by 김주희 on 1/13/26.
//

import Foundation

public class RecordManager {
    var trialCounts: Array<Int> = []

    func add(_ trialcount: Int){
        trialCounts.append(trialcount)
    }
    
    func showRecords() {
        for (idx, value) in trialCounts.enumerated() {
            print("\(idx + 1)번째 게임: 시도 횟수 - \(value)")
        }
    }
    
}
