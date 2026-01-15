//
//  BaseballGame.swift
//  juhee
//
//  Created by 김주희 on 1/13/26.
//

import Foundation

public class BaseballGame { // 야구 게임 진행 클래스
    
    var recordManager = RecordManager() // 기록을 관리하는 인스턴스 생성
    var gameCenter = GameCenter() // 게임 연산 계산 인스턴스 생성
    var gameCounter = GameCounter(trial: 0)
    
    func start() {
        
        while true {
            print("환영합니다! 원하시는 번호를 입력해주세요")
            print("1. 게임 시작하기 2. 게임 기록 보기 3. 종료하기")
            
            switch readLine() {
            case "1":
                playGame()
            case "2":
                print("<게임 기록 보기>")
                recordManager.showRecords() // showRecords 함수 호출
            case "3":
                print("< 숫자 야구 게임을 종료합니다. >")
                exit(0) // 강제 종료 함수 출력
            default:
                print("올바른 숫자를 입력해주세요!")
            }
        }
        
        
        func playGame(){
            let answer = gameCenter.makeAnswer() // 정답 만드는 함수
            print("<게임을 시작합니다>")
            
            while true {
                print("숫자를 입력하세요")
                guard let input = readLine(),
                      let inputNumber = Int(input), // 숫자로 변환
                      gameCenter.checkInput(inputNumber) // 입력값 검사 함수 호출
                else {
                    print("올바르지 않은 입력값입니다.")
                    continue // 다시 입력하도록 while문 다시 실행
                }
                
                gameCounter.trial += 1 // 올바른 숫자를 입력하였으므로 시도횟수 +1
                
                if gameCenter.compareInput(inputNumber, answer) == "정답" {
                    // "정답"return하면 반복문에서 빠져나감
                    recordManager.add(gameCounter.trial) // 정답이므로 배열에 최종 시도 횟수 입력
                    gameCounter.trial = 0 // 해당 게임 시도 횟수 0으로 초기화
                    break
                }
            }
        }
    }
    

    
    
}
