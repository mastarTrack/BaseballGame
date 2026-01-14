//
//  ErrorEnum.swift
//  Baseball
//
//  Created by Hanjuheon on 1/13/26.
//

/// 입력된 값에 대한 에러 처리 열거형
enum ErrorDuplicate: Error{
    /// 숫자외의 값이 입력되었음
    case IsNotNumber
    /// 중복된 숫자가 존재
    case IsDuplicate
    /// 입력된 숫자가 많음
    case InvalidNumberCount
}

enum ErrorInput: Error{
    /// 숫자외의 값이 입력되었음
    case IsNotNumber
    /// 지정된 값이 아님
    case NotSpecifiedValue
}
