//
//  Game.swift
//  BaseballGame
//
//  Created by 변예린 on 1/13/26.
//

import Foundation

class BaseballGame {
    private let messagePrinter: MessagePrinter
    private let recordManager: RecordManager
    private let inputManager: InputManager
    private let gameManager: GameManager
    
    init(messagePrinter: MessagePrinter, recordManager: RecordManager, inputManager: InputManager, gameManager: GameManager) {
        self.messagePrinter = messagePrinter
        self.recordManager = recordManager
        self.inputManager = inputManager
        self.gameManager = gameManager
    }
    
    // 게임 시작 함수
    func start() {
        var isExit = false
        
        while !isExit {
            messagePrinter.welcome()
            let selected = selectMenu() // 메뉴 선택
            
            // 선택 메뉴에 따른 함수 실행
            switch selected {
            case .play:
                messagePrinter.startGame()
                play()
            case .record:
                messagePrinter.showRecordTitle()
                showRecord()
            case .exit:
                recordManager.resetRecord()
                messagePrinter.endGame()
                isExit = true
            }
        }
    }
    
    // 메뉴 선택 함수
    private func selectMenu() -> Menu {
        while true {
            // 유저 입력값
            let input = inputManager.inputMenu()
            
            if let input = input {
                return input // 유효한 입력값일 경우 Menu 타입 반환
            } else {
                messagePrinter.error(.invalid(for: .menu)) // 에러 메세지 출력
            }
        }
    }
    
    // 게임 플레이 함수
    private func play() {
        recordManager.addRound() // 게임 기록 생성
        let answer = gameManager.setAnswer() // 정답 생성
        
        debugPrint(answer) // 디버깅용 정답 출력
        
        while true { // 정답을 맞힐 때까지 반복
            let userAnswer = getUserAnswer()
            
            let result = gameManager.check(userAnswer, with: answer)
            messagePrinter.result(result)
            
            recordManager.addAttempt()
            if result.correct { break }
        }
    }

    // 유저 정답 생성 함수
    private func getUserAnswer() -> [Int] {
        while true {
            let input = inputManager.inputUserAnswer() // 유저 입력값
            let verification = inputManager.verify(input) // 유효성 검사

            if verification == .valid {
                return input // 정상 입력일 경우
            } else if verification == .duplicate {
                messagePrinter.error(.duplicate) // 유저 입력에 중복 숫자가 있을 경우
            } else if verification == .invalid(for: .answer) {
                messagePrinter.error(.invalid(for: .answer)) // 유저 입력이 3자리 숫자가 아닐 경우
            }
        }
    }
    
    // 기록 조회 함수
    private func showRecord() {
        let record = recordManager.fetchRecord()
        
        // 기록이 없는 경우
        if record.attempts.isEmpty {
            messagePrinter.noRecord()
        } else {
            // 게임 기록 출력
            for i in record.attempts.indices {
                print(GameMessage.getRecord(for: i, attempt: record.attempts[i]))
            }
            print("\n", terminator: "")
        }
    }
}
