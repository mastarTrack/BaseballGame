//
//  FuncViewRecord.swift
//  Baseball
//
//  Created by Hanjuheon on 1/14/26.
//
import Foundation

/// 기록 출력 함수
func printRecord(records: [Int:Int]){
    // 게임 진행 기록이 없을 시 문구 출력
    if records.count == 0{
        print(GameMessages.newPlayerRecored.rawValue)
    }
    // 게임 진행 기록이 있을 시 기록 출력
    else{
        for data in records{
            print(GameMessages.textToRecord(gameCount: data.key, tryCount: data.value))
        }
        print("총 \(records.count)번의 게임을 진행하셨습니다.")
    }
    
    sleep(2)
    print(GameMessages.returnMenu.rawValue)
    // 리턴값을 사용하지 않을때 발생하는 경고 지우기
    _ = readLine()
}
