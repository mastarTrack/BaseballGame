//
//  Game.swift
//  BaseballGame
//
//  Created by 변예린 on 1/13/26.
//

import Foundation

class BaseballGame {
    var isExit = false
    
    var answer: [Int] = []
    var userAnswer: [Int] = []
    
    var isCorrect = false
    var hint: (strike: Int, ball: Int) = (0, 0)
    
    //게임 시작 함수
    func start() {
        while !isExit {
            isCorrect = false
            
            guard let selected = selectMenu() else {
                print("유효하지 않은 입력입니다!")
                return
            }
            
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
    
    // 메뉴 선택 함수
    func selectMenu() -> Menu? {
        print("""
            환영합니다! 원하시는 번호를 입력해주세요. (예: 1)
            1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기
            """)
        
        let condition = ["1", "2", "3"]
        var menu = ""
        
        // 메뉴 입력
        var input = readLine() ?? ""
        // 입력문 공백 삭제
        menu = input.replacingOccurrences(of: " ", with: "")
        
        // 입력문 유효성 검사
        while !condition.contains(menu) {
            print("유효하지 않은 입력입니다. 다시 입력해주세요. (예: 1)")
            input = readLine() ?? ""
            menu = input.replacingOccurrences(of: " ", with: "")
        }
        
        switch menu {
        case "1":
            return .play
        case "2":
            return .record
        case "3":
            return .exit
        default:
            return nil
        }
    }
    
    // 게임 플레이 함수
    func play() {
        print("\n❮게임을 시작합니다.❯")
        setAnswer() // 정답 생성
        
        // 정답을 맞힐 때까지 반복
        while !isCorrect {
                getUserAnswer()
                checkAnswer()
        }
    }
    
    // 정답 생성 함수
    func setAnswer() {
        // 초기화
        isCorrect = false
        answer = []
        
        for _ in 0...2 {
            var num = Int.random(in: 0...9)
            
            // 정답 첫 번째 숫자일 경우
            if answer.isEmpty {
                // num == 0이라면 재생성
                while num == 0 {
                    num = Int.random(in: 0...9)
                }
            } else {
                // 정답에 포함되어있다면 num 재생성
                while answer.contains(num) {
                    num = Int.random(in: 0...9)
                }
            }
            answer.append(num)
        }
        print("정답: \(answer)")
    }
    
    // 유저 정답 입력 함수
    func getUserAnswer() {
        print("3자리 숫자를 입력해주세요. (예: 123)")
        
        // 유저 입력
        let input = readLine() ?? ""
        
        // 공백 삭제
        let stringNum = input.replacingOccurrences(of: " ", with: "")
        
        // 유저 입력 배열
        userAnswer = stringNum.compactMap{ Int(String($0)) }
        
        // 유저 입력이 3자리 숫자가 아닐 경우의 예외 처리
        guard userAnswer.count == 3 else {
            print("유효하지 않은 입력입니다!\n")
            return
        }
    }
    
    // 정답 & 유저 입력 비교 함수
    func checkAnswer() {
        // 힌트 초기화
        hint.strike = 0
        hint.ball = 0
        
        // 유저 입력 정답 오류 시 무시
        guard userAnswer.count == 3 else { return }
        
        // 힌트 설정(스트라이크, 볼)
        userAnswer.enumerated().forEach {
            if answer[$0.offset] == $0.element {
                hint.strike += 1
            } else if answer.contains($0.element) {
                hint.ball += 1
            }
        }
        
        // 힌트에 따른 분기 처리
        if hint.strike == 3 {
            isCorrect = true
            print("정답입니다!\n")
        } else if hint.strike == 0 && hint.ball == 0 {
            print("Nothing\n")
        } else {
            print("🎯 \(hint.strike) 스트라이크 ⚾️ \(hint.ball) 볼 입니다!\n")
        }
    }
    
    func record() {
        
    }
}
