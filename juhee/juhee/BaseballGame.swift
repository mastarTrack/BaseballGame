//
//  BaseballGame.swift
//  juhee
//
//  Created by 김주희 on 1/13/26.
//

import Foundation

public class BaseballGame { // 야구 게임 진행 클래스
    
    private var gameCenter = GameCenter() // 게임 연산 계산 인스턴스 생성
    private var recordManager = RecordManager() // 게임 기록을 관리하는 인스턴스 생성

    //  MARK: - 게임 선택 함수
    func start() {
        
        while true {
            print("환영합니다!🤗 원하시는 번호를 입력해주세요 💬")
            print("1. 게임 시작하기 ⚾️  2. 게임 기록 보기 📋  3. 종료하기 ⛔️")
            
            switch readLine() {
            case "1":
                print("\n< Round \(recordManager.trialCounts.count + 1): 게임을 시작합니다 >")
                playGame() // 야구게임 진행 메소드 실행
            case "2":
                print("\n< 게임 기록 보기 📋 >")
                recordManager.showRecords() // showRecords 함수 호출
            case "3":
                print("\n< 숫자 야구 게임을 종료합니다. ⛔️ >")
                exit(0) // 강제 종료 함수 실행
            default:
                print("올바른 숫자를 입력해주세요! 😤")
            }
        }
        
        
        //  MARK: - 농구 게임 시작 함수
        func playGame(){
            
            let answer = gameCenter.makeAnswer() // 정답 만드는 함수 호출
            var isplay = true
            while isplay { // 입력값 검사 반복문
                print("숫자를 입력하세요:")
                guard let inputNumber = readLine().flatMap(Int.init), // 올바른 입력값인지 검사
                      gameCenter.checkInput(inputNumber) // 입력값 검사 함수 호출
                else {
                    print("올바르지 않은 입력값입니다.😤 다시 입력해주세요!\n")
                    continue
                }
                
                recordManager.addTrial() // 올바른 숫자를 입력하였으므로 시도횟수 +1
                
                let result = gameCenter.compare(inputNumber, answer)
                
                switch result {
                case .correct:
                    print("정답입니다!✔️\n")
                    recordManager.add(recordManager.trial) // 정답이므로 배열에 최종 시도 횟수 입력
                    recordManager.trial = 0 // 게임 시도 횟수 0으로 초기화
                    isplay = false
                case .nothing:
                    print("Nothing 😵\n")
                case .progress(let s, let b):
                    print("\(s) 스트라이크 \(b) 볼\n")
                }
            }
        }
    }
}
