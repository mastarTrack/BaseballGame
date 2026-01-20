//
//  Game.swift
//  BaseballGame
//
//  Created by 변예린 on 1/13/26.
//

import Foundation

/* 게임의 시스템을 관리하는 클래스입니다.
 각 기능을 담당하는 클래스에게 명령을 내려 핵심 기능을 수행합니다. */

class GameController {
    private let messagePrinter: MessagePrinter
    private let recordManager: RecordManager
    private let inputManager: InputManager
    private let gameComputer: GameComputer
    
    init(messagePrinter: MessagePrinter, recordManager: RecordManager, inputManager: InputManager, gameComputer: GameComputer) {
        self.messagePrinter = messagePrinter
        self.recordManager = recordManager
        self.inputManager = inputManager
        self.gameComputer = gameComputer
    }
    
    // 게임 시작 함수
    func start() {
        var isExit = false
        
        while !isExit {
            messagePrinter.welcome()
            let selected = selectMenu() // 메뉴 선택
            
            // 선택 메뉴에 따른 함수 실행
            switch selected {
            case .play: // 게임 시작
                messagePrinter.startGame()
                play()
            case .record: // 기록 조회
                messagePrinter.showRecordTitle()
                showRecord()
            case .exit: // 게임 종료
                recordManager.resetRecord()
                messagePrinter.endGame()
                isExit = true
            }
        }
    }
    
    // 메뉴 선택 함수
    private func selectMenu() -> Menu {
        while true {
            do {
                let input = try inputManager.inputMenu() // 유저 입력값
                return input // 유효할 경우
            } catch InputError.invalid(for: .menu) {
                messagePrinter.error(.invalid(for: .menu)) // 오류 메세지 출력
            } catch {
                messagePrinter.unknownError() // 알 수 없는 오류
            }
        }
    }
    
    // 게임 플레이 함수
    private func play() {
        recordManager.addRound() // 게임 기록 생성
        let answer = gameComputer.setAnswer() // 정답 생성
        
        debugPrint(answer) // 디버깅용 정답 출력
        
        while true { // 정답을 맞힐 때까지 반복
            let userAnswer = getUserAnswer() // 유저 정답 생성
            
            // 정답 확인
            let result = gameComputer.check(userAnswer, with: answer)
            messagePrinter.result(result) // 결과 출력
            
            // 기록 변경
            recordManager.addAttempt()
            if result.correct { break } // 정답 시 게임 종료
        }
    }

    // 유저 정답 생성 함수
    private func getUserAnswer() -> [Int] {
        while true {
            do {
                let input = try inputManager.inputUserAnswer()
                return input
            } catch InputError.duplicate {
                messagePrinter.error(.duplicate)
            } catch InputError.invalid(for: .answer) {
                messagePrinter.error(.invalid(for: .answer))
            } catch {
                messagePrinter.unknownError()
            }
        }
    }
    
    // 기록 조회 함수
    private func showRecord() {
        let record = recordManager.fetchRecord() // 기록 불러오기
        
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
