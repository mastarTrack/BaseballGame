//
//  FuncUtils.swift
//  Baseball
//
//  Created by Hanjuheon on 1/15/26.
//
import Foundation

/// String 타입을 [Int] 배열로 변환 처리 함수
///
/// 다음 조건에 만족하는 문자열일 시 정수 배열로 리턴
/// 1. 매개변수값이 숫자여야한다.
/// 2. 입력된 숫자가 3자리여야한다.
/// 3. 각 자리 숫자가 중복이 없어야한다.
func checkInputData(_ text: String?) throws -> [Int]{
    
    // 입력값에 문자있는지 확인
    guard let number = text,
          number.allSatisfy({ $0.isNumber }) else {
        throw ErrorDuplicate.IsNotNumber
    }
    
    let checkNumber = number.compactMap{ Int(String($0)) }
    
    // 입력된 숫자가 3자리 수인지 확인
    if checkNumber.count != 3{
        throw ErrorDuplicate.InvalidNumberCount
    }

    // 중복된 숫자 체크
    if Set(checkNumber).count != 3{
        throw ErrorDuplicate.IsDuplicate
    }
        
    return checkNumber
}


/// String 타입을 조건에 충족할 시 Int로 변환 처리 함수
///
///  매개변수값이 숫자로 구성되어 있어야 하며 1부터 3사이의 값이여야 한다.
func checkInputNumber(_ input: String?) throws ->  Int{
    guard let text  = input,
          let number = Int(text.trimmingCharacters(in: .whitespacesAndNewlines) ) else{
        throw ErrorInput.IsNotNumber
    }
    
    if !(1...3).contains(number){
        throw ErrorInput.NotSpecifiedValue
    }
    
    return number
}
