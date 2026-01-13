//
//  ModelComputer.swift
//  Baseball
//
//  Created by Hanjuheon on 1/13/26.
//

// 컴퓨터 모델 클래스
class computer{
    private var baseballNumber: [Int] = []
    
    func setNumber(_ number: [Int]){
        self.baseballNumber = number
    }
    
    func getNumber()-> [Int]{
        baseballNumber
    }
}
