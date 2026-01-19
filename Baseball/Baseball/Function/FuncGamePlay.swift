//
//  FuncGamePlay.swift
//  Baseball
//
//  Created by Hanjuheon on 1/13/26.
//
import Foundation

/// Baseball 게임 함수
func startBaseBall(_ playerGameCount: Int) -> [Int: Int] {
    /// 컴퓨터 모델 변수 생성
    let gameManager = GameManager()

    /// 게임 무한루프 체크 변수
    var playing = true
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
    gameManager.setNumber()

    // 게임 진행
    while playing{
        sleep(1)
        print(GameMessages.inputNumber.rawValue)
        do {
            let userBallNum = try checkInputData(readLine())
            tryCount += 1
            
            // 입력값에 대한 결과 처리 확인
            let (strike, ball) = gameManager.checkStrikeAndBall(user: userBallNum)
            
            // 정답일 시 처리 코드
            if strike == 3{
                print(GameMessages.correct.rawValue)
                recordDIc[GameCount] = tryCount
                sleep(1)
                print(GameMessages.rePlaying.rawValue)
                checkQuit(&playing)
                if !playing {
                    break
                } else {
                    print(GameMessages.gameStart.rawValue)
                    gameManager.setNumber()
                    GameCount += 1
                    tryCount = 0
                }
            } else if strike == 0 && ball == 0 { // 아무것도 못맞추었을때 처리 코드
                print(GameMessages.nothing.rawValue)
            } else{ // 부분 정답일시 처리 코드
                print(GameMessages.textResult(strike: strike, ball: ball))
            }
        } catch ErrorDuplicate.IsNotNumber {
            print(GameMessages.notNumber.rawValue)
            continue
        } catch ErrorDuplicate.InvalidNumberCount {
            print(GameMessages.invalidCount.rawValue)
            continue
        } catch ErrorDuplicate.IsDuplicate {
            print(GameMessages.duplicate.rawValue)
            continue
        } catch {
            print("사용자값 체크 중 에러 발생: \(error)")
        }
        
       
    }
    return recordDIc
}

/// 반복 플레이 여부 확인 함수
func checkQuit(_ playing: inout Bool){
    if readLine()?.lowercased() == "q" {
        playing = false
    } else {
        playing = true
    }
}
