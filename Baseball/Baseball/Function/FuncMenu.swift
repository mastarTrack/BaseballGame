//
//  FuncMenu.swift
//  Baseball
//
//  Created by Hanjuheon on 1/14/26.
//

import Foundation

/// baseball 게임 메인 실행 함수
func startMainMenu(){

    /// 사용자 정보 상수
    let user: User = User()
    /// 게임 무한 루프 체크용 bool 변수
    var playing = true
    
    print("사용자 정보를 확인하겠습니다.")
    print("사용자 아이디를 입력해주세요(영문권장)")
    user.setName(readLine() ?? "")
    
    // 메인 메뉴 루프
    while playing {
        print(GameMessages.textMainMenu(user.getName()))
        do{
            switch try checkInputNumber(readLine()){
            /// 야구게임 실행
            case 1:
                user.insertRecord(recordDic: startBaseBall(user.getRecord().count))
            /// 유저 플레이 기록 확인
            case 2:
                printRecord(records: user.getRecord())
            /// 게임종료
            case 3:
                playing = false
            default:
                continue
            }
        }
        catch ErrorInput.IsNotNumber{
            print(GameMessages.notNumber.rawValue)
        }
        catch ErrorInput.NotSpecifiedValue{
            print(GameMessages.NotSpecifiedValue.rawValue)
        }
        catch{
            print("메뉴 선택 중 에러 발생: \(error)")
        }
    }
    print(GameMessages.quitText.rawValue)
}


