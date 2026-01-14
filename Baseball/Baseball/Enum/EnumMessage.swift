//
//  EnumMessage.swift
//  Baseball
//
//  Created by Hanjuheon on 1/13/26.
//

enum GameMessages: String {
    
    case mainMenu = """
        
        """
    
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
    
    /// 프로그램에서 지원하지 않는 값 입력 시 출력 문구
    case NotSpecifiedValue = "안내드린 메뉴 번호값(1,2,3)만 입력해주세요."
    
    /// 3자리수 이상 입력 시 출력 문구
    case invalidCount = "3자리의 숫자를 입력해주세요."
    
    /// 중복된 숫자값 존재 시  출력 문구
    case duplicate = "중복된 숫자값이 존재합니다. 중복되지않는 3자리 숫자를 입력해주세요."
    
    /// 결과값이 모두 불일치 문구
    case nothing = "Nothing, 아무것도 일치하지 않았습니다."
    
    /// 정답 시 출력 문구
    case correct = "정답입니다."
    
    /// 게임 종료 후 중간 확인 문구
    case rePlaying = "게임을 계속하시려면 아무 값이나 입력해주세요, \n만약 종료하시겠다면 \"Q/q\"를 입력해주세요."
    
    /// 메뉴 리턴 문구
    case returnMenu = "메뉴로 돌아가시려면 아무 값을 입력해주세요."
    
    case newPlayerRecored = "게임을 진행한 기록이 없습니다."
    
    /// 메인 종료 후 문구
    case quitText = """
        Baseball 게임을 종료합니다.
        플레이 해주셔서 감사합니다.
        """
    
    
    /// 메인메뉴 문구 제작 함수
    static func textMainMenu(_ name: String) -> String{
        return """
            환영합니다, \(name)님! 원하시는 번호를 입력해주세요
            1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기
            """
    }
    
    /// 사용자 인사 제작 함수
    static func textWelcomeUser(_ name: String) -> String {
        return "\(name)님 안녕하세요."
    }
    
    /// 결과 택스트 제작 함수
    static func textResult(strike: Int, ball: Int) -> String {
        var text = ""
        if strike > 0 { text += "\(strike) 스트라이크 " }
        if ball > 0 { text += "\(ball) 볼" }
        return text
    }
    
    static func textToRecord(gameCount: Int, tryCount: Int)-> String{
        return "\(gameCount)번째 게임 : 시도 횟수 - \(tryCount)"
    }
}
