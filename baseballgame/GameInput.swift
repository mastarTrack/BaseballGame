//
//  GameInput.swift
//  aa
//
//  Created by 손영빈 on 1/15/26.
//


// GameIput 소스코드는 사용자의 입력을 받고, 입력된 값이 정상적인지 판단하기 위한 객체를 만들었습니다. 조건(1. 숫자가 아닌 다른 값의 입력, 2. 중복된 값의 입력)을 통해 정상적인 값이 아니라는 것이 판단되면 nil을 반환하여 game의 while 구문 guard let에서 걸리게 되어 입력을 다시 받도록 구현되어있습니다. 또한, guard let에 조건을 모두 넣어보고자 Optional을 감싸서 compactMap을 사용하였습니다. map대신 compactMap을 사용하고자 한 이유에 대해서는 아래 코드의 주석을 참고해주시면 될 것 같습니다.

import Foundation

struct GameInput {
    func getInput() -> [Int]? {
        /* (Lv.2) 1. 사용자 입력 검증 */
        print("숫자를 입력하세요: ", terminator: "\n")
        guard let input = readLine(),
              let num = Optional(input.compactMap{Int(String($0))}), //숫자 외의 다른 값이 들어왔는지 확인, map 대신 compactMap 사용 : map 사용시 nil로 처리 되기 때문에 처리가 바르게 일어나지않음(ex. 1ab입력시 num = [1,nil,nil] -> 중복으로 처리됨
              num.count == 3
        else {
            print("올바르지 않은 입력값입니다.")
            return nil
        }
        
        if Set(num).count != 3 { //중복된 값이 있는지 확인
            print("올바르지 않은 입력값입니다.(중복)")
            return nil
        }
        return num
    }
}
