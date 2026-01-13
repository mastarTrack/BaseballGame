//
//  ModelUser.swift
//  Baseball
//
//  Created by Hanjuheon on 1/13/26.
//

/// 유저 모델 클래스
class User{
    private var name: String
    private var baseballNumber: [Int] = []
    private var playCount: Int = 0
    
    init(name: String) {
        self.name = name
    }
    
    func setName(_ name: String){
        self.name = name
    }
    
    func getName() -> String{
        name
    }
    
    func setNumber(_ number: [Int]){
        self.baseballNumber = number
    }
    
    func getNumber()-> [Int]{
        baseballNumber
    }
    
    func playGame(){
        playCount += 1
    }
    
    func getPlayCount()-> Int{
        playCount
    }
}
