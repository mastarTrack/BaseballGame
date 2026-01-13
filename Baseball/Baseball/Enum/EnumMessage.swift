//
//  EnumMessage.swift
//  Baseball
//
//  Created by Hanjuheon on 1/13/26.
//

enum GameMessages: String {
    /// 게임 룰 문구
    case gameRule = """
        게임 설명.
        - 컴퓨터는 게임시작과 동시에 중복숫자가 없는 랜덤 3자리 숫자를 부여받습니다.
        - 도전자는 중복없는 숫자 3자리를 입력하여 정확히 맞추는 게임입니다.
        - 정확히 맞추지 못할 시에는 컴퓨터 숫자에 대한 힌트가 공유됩니다.
        - 숫자와 자릿수를 모두 맞추었을 경우 Strike 카운트가 올라갑니다.
        - 숫자만 맞추셨을 경우 Ball 카운트가 올라갑니다.
        - 컴퓨터의 숫자를 모두 맞추어 3 Strike가 되면 플레이어 우승으로 게임이 종료됩니다.
        """

    // 게임 시작 문구
    case gameStart = "게임을 시작겠습니다. 컴퓨터 숫자 배치중..."
    
    /// 숫자 입력 요청 문구
    case inputNumber = "숫자를 입력해주세요."
    
    /// 숫자외 다른 문자 입력 시 출력 문구
    case notNumber = "다른 문자값이 입력되었습니다. 숫자만 입력해주세요."
    
    /// 3자리수 이상 입력 시 출력 문구
    case invalidCount = "3자리의 숫자만 입력해주세요."
    
    /// 중복된 숫자값 존재 시  출력 문구
    case duplicate = "중복된 숫자값이 존재합니다. 중복되지않는 3자리 숫자를 입력해주세요."
    
    /// 결과값이 모두 불일치 문구
    case nothing = "Nothing, 아무것도 일치하지 않았습니다."
    
    /// 정답 시 출력 문구
    case correct = "정답입니다."
    
    /// 사용자 인사 함수
    static func welcomeUser(_ name: String) -> String {
        return "\(name)님 안녕하세요."
    }
    
    /// 결과 택스트 생성 함수
    static func result(strike: Int, ball: Int) -> String {
        var text = ""
        if strike > 0 { text += "\(strike) 스트라이크 " }
        if ball > 0 { text += "\(ball) 볼" }
        return text
    }
}
