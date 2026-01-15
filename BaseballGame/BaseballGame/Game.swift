//
//  Game.swift
//  BaseballGame
//
//  Created by 변예린 on 1/13/26.
//

import Foundation

class BaseballGame {
    // private 캡슐화
    private var isExit = false
    
    private let gameManager = BaseballGameManager()

    // 굳이 변수가 여기 선언될 필요가 있는가. 1회성인데
    var gameRecord: [Int] = []
    var gameCount = 0
    
    //MARK: 게임 시작 함수
    func start() {
        isExit = false
        while !isExit, let selected = gameManager.selectMenu() {
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
        exit()
    }

    //MARK: 게임 플레이 함수
    func play() {
        print(GameMessage.startGame)
        
        gameRecord.append(0) // 게임 기록 생성
        let answer = setAnswer() // 정답 생성
        var isCorrect = false
        debugPrint("정답: \(answer)")
        
        // 정답을 맞힐 때까지 반복
        while !isCorrect {
            let userAnswer = getUserAnswer()
            let result = gameManager.checkAnswer(userAnswer, with: answer)
            isCorrect = result.correct
            print(printResult(result))
            gameRecord[gameCount] += 1 // 시도 횟수 증가
        }
        gameCount += 1 // 게임 횟수 증가
    }
    
    // 정답 생성 함수
    func setAnswer() -> [Int] {
//        var num = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9] // 정답 숫자 후보
//        num.shuffle() // 숫자 배열 섞기
//        let answer = num[0] != 0 ? Array(num[0...2]) : Array(num[1...3]) // 첫 번째 숫자가 0일 경우 예외 처리
        
        return Array((0...9).shuffled() // 숫자 섞기
            .trimmingPrefix(while: { $0 == 0 }) // while 조건에 맞는 첫 글자 삭제
            .prefix(3))

    }
    
    // 유저 정답 입력 함수
    func getUserAnswer() -> [Int] {
        print(GameMessage.userAnswerExample)
        
        while true {
            // 유저 입력
            let input = readLine() ?? ""
            // 유저 입력 배열
            let userAnswer = input.compactMap{ Int(String($0)) }
            
            if userAnswer.count != 3 { // 유저 입력이 3자리 숫자가 아닐 경우
                print(GameMessage.invalidInput, GameMessage.userAnswerExample)
            } else if Set(userAnswer).count != 3 { // 유저 입력에 중복 숫자가 있을 경우
                print(GameMessage.duplicateInput, GameMessage.userAnswerExample)
            } else {
                return userAnswer
            }
        }
    }
    
    func printResult(_ result: (strike: Int, ball: Int, correct: Bool)) -> String {
        if result.correct {
            return GameMessage.correct
        } else if result.strike == 0 && result.ball == 0 {
            return GameMessage.nothing
        } else {
            return GameMessage.getHint(for: result.strike, result.ball)
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
    @inlinable func inputWithNoSpace() -> String { // @Inlinable 하면 인라이닝해서 치환되는데.. 요거 별로 안쓰이는데 필요한가?
        var input = readLine() ?? ""
        input = input.trimmingCharacters(in: .whitespacesAndNewlines)
        return input
    }
}
