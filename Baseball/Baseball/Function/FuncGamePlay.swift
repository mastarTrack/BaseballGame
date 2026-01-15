//
//  FuncGamePlay.swift
//  Baseball
//
//  Created by Hanjuheon on 1/13/26.
//
import Foundation

/// Baseball 게임 함수
func startBaseBall(_ playerGameCount: Int) -> [Int: Int]{
    /// 컴퓨터 모델 변수 생성
    let computer: Computer = Computer()

    /// 게임 무한루프 체크 변수
    var playing = true
    /// 유져 입력값 저장용 배열 변수
    var userBallNum: [Int] = []
    /// strike, bool 결과 값을 담기위한 튜플 변수
    var checkResult: (Int,Int)
    /// 게임 기록을 저장하기위한 딕셔너리 변수
    var recordDIc: [Int: Int] = [:]
    /// 현재 게임 횟수를 저장하기위한 변수
    var GameCount = playerGameCount + 1
    /// 게임에서 진행한 도전 획수 저장용 변수
    var tryCount = 0
    
    // 게임 룰 설명
    print(GameMessages.gameRule.rawValue)
    
    // 게임시작
    print(GameMessages.gameStart.rawValue)
    computer.setNumber(randomForBaseball())

    // 게임 진행
    while playing{
        sleep(1)
        print(GameMessages.inputNumber.rawValue)
        do {
            userBallNum = try checkInputData(readLine())
            tryCount += 1
        }catch ErrorDuplicate.IsNotNumber{
            print(GameMessages.notNumber.rawValue)
            continue
        }catch ErrorDuplicate.InvalidNumberCount{
            print(GameMessages.invalidCount.rawValue)
            continue
        }catch ErrorDuplicate.IsDuplicate{
            print(GameMessages.duplicate.rawValue)
            continue
        }catch{
            print("사용자값 체크 중 에러 발생: \(error)")
        }
        
        // 입력값에 대한 결과 처리 확인
        checkResult = checkStrikeAndBall(target: computer.getNumber(), guess:userBallNum)
        
        // 정답일 시 처리 코드
        if checkResult.0 == 3{
            print(GameMessages.correct.rawValue)
            recordDIc[GameCount] = tryCount
            sleep(1)
            print(GameMessages.rePlaying.rawValue)
            checkQuit(&playing)
            if !playing{
                print("\u{001B}")
                break
            }
            else{
                print(GameMessages.gameStart.rawValue)
                computer.setNumber(randomForBaseball())
                GameCount += 1
                tryCount = 0
            }
        }
        // 아무것도 못맞추었을때 처리 코드
        else if checkResult.0 == 0 && checkResult.1 == 0{
            print(GameMessages.nothing.rawValue)
        }
        // 부분 정답일시 처리 코드
        else{
            print(GameMessages.textResult(strike: checkResult.0, ball: checkResult.1))
        }
    }
    return recordDIc
}

/// 반복 플레이 여부 확인 함수
func checkQuit(_ playing: inout Bool){
    if readLine()?.lowercased() == "q" {
        playing = false
    }
    else{
        playing = true
    }
}
