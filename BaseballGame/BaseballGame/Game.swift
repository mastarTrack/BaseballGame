//
//  Game.swift
//  BaseballGame
//
//  Created by 변예린 on 1/13/26.
//

import Foundation

class BaseballGame {
    var isExit = false
    var isCorrect = false
    
    var answer: [Int] = []
    var userAnswer: [Int] = []
    
    var gameRecord: [Int] = []
    var gameCount = 0
    
    //MARK: 게임 시작 함수
    func start() {
        isExit = false
        while !isExit {
            if let selected = selectMenu() {
                // 입력 번호에 따른 함수 실행
                switch selected {
                case .play:
                    play()
                case .record:
                    record()
                case .exit:
                    isExit = true
                }
            }
        }
        exit()
    }
    
    // 메뉴 선택 함수
    func selectMenu() -> Menu? {
        print(GameMessage.welcome)

        let condition = ["1", "2", "3"]
        var menu = inputWithNoSpace()
        
        // 입력문 유효성 검사
        while !condition.contains(menu) {
            print(GameMessage.invalidInput, GameMessage.selectMenuExample)
            menu = inputWithNoSpace() // 입력값 공백 제거 함수 확장에 구현
        }
        return Menu(rawValue: menu)
    }
    
    //MARK: 게임 플레이 함수
    func play() {
        print(GameMessage.startGame)
        gameRecord.append(0) // 게임 기록 생성
        setAnswer() // 정답 생성
        
        // 정답을 맞힐 때까지 반복
        while !isCorrect {
            getUserAnswer()
            checkAnswer()
            gameRecord[gameCount] += 1 // 시도 횟수 증가
        }
        gameCount += 1 // 게임 횟수 증가
    }
    
    // 정답 생성 함수
    func setAnswer() {
        // 초기화
        isCorrect = false
        answer = []
        
        var num = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9] // 정답 숫자 후보
        num.shuffle() // 숫자 배열 섞기
        answer = num[0] != 0 ? Array(num[0...2]) : Array(num[1...3]) // 첫 번째 숫자가 0일 경우 예외 처리
        
        debugPrint("정답: \(answer)")
    }
    
    // 유저 정답 입력 함수
    func getUserAnswer() {
        print(GameMessage.userAnswerExample)
        
        // 초기화
        userAnswer = []
        var isValid = false

        while !isValid {
            // 유저 입력
            let input = readLine() ?? ""
            // 유저 입력 배열
            userAnswer = input.compactMap{ Int(String($0)) }
            
            if userAnswer.count != 3 {
                print(GameMessage.invalidInput, GameMessage.userAnswerExample)
            } else if Set(userAnswer).count != 3 {
                print(GameMessage.duplicateInput, GameMessage.userAnswerExample)
            } else {
                isValid = true
            }
        }
    }
    
    // 정답 & 유저 입력 비교 함수
    func checkAnswer() {
        // 힌트 초기화
        var hint: (strike: Int, ball: Int) = (0, 0)
        // 힌트 설정(스트라이크, 볼)
        for (i, element) in userAnswer.enumerated(){
            if answer[i] == element {
                hint.strike += 1
            } else if answer.contains(element) {
                hint.ball += 1
            }
        }
        
        // 힌트에 따른 분기 처리
        if hint.strike == 3 {
            isCorrect = true
            print(GameMessage.correct)
        } else if hint.strike == 0 && hint.ball == 0 {
            print(GameMessage.nothing)
        } else {
            print(GameMessage.getHint(for: hint.strike, hint.ball))
        }
    }
    
    //MARK: 게임 기록 조회 함수
    func record() {
        print(GameMessage.recordTitle)
        
        // 게임 기록이 없을 경우
        guard !gameRecord.isEmpty else {
            print(GameMessage.noRecord)
            return
        }

        // 게임 기록 출력
        for i in 0..<gameRecord.count {
            print(GameMessage.getRecord(for: i, attempt: gameRecord[i]))
        }
        print("\n", terminator: "")
    }
    
    //MARK: 게임 종료 함수
    func exit() {
        // 게임 기록 초기화
        gameRecord = []
        gameCount = 0
        
        print(GameMessage.endGame)
        
    }
}

//MARK: 부가 기능 구현부
extension BaseballGame {
    // 입력값 공백 제거
    func inputWithNoSpace() -> String {
        var input = readLine() ?? ""
        input = input.trimmingCharacters(in: .whitespacesAndNewlines)
        return input
    }
}
