//
//  ModelUser.swift
//  Baseball
//
//  Created by Hanjuheon on 1/13/26.
//

/// 유저 모델 클래스
class User{
    /// 사용자 이름 변수
    var name: String = "Guest"
    /// 사용자 게임 기록 딕셔너리 변수
    private(set) var records: [Int : Int] = [:]

    func insertRecord(recordDic: [Int: Int]){
        for data in recordDic{
            records[data.key] = data.value
        }
    }
    
}
