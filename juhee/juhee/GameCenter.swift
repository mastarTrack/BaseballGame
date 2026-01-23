//
//  GameCenter.swift
//  juhee
//
//  Created by 김주희 on 1/14/26.
//

import Foundation

class GameCenter { // 게임에 필요한 계산을 하는 클래스
    var gameNumber = 3
    
    // MARK: - 입력한 세자리 수를 숫자 각 한개씩으로 배열로 쪼개는 내부 로직 함수
    private func splitNum(_ num: Int) -> [Int] {
        return String(num).compactMap { $0.wholeNumberValue }
        }
        
        
        // MARK: - 정답 만드는 함수
        func makeAnswer() -> [Int] {
            let arr = (0...9).map { $0 }
            
            let shuffledArr = arr.shuffled() // 배열을 랜덤으로 섞어줌
            
            if shuffledArr[0] == 0 {
                return [Int](shuffledArr[1...gameNumber]) // Int 배열로 형변환 필수
            } else {
                return [Int](shuffledArr[0...gameNumber - 1])
            }
        }
        
        
        // MARK: - 사용자가 입력한 값 검증 함수
        func checkInput(_ inputNumber: Int) -> Bool {
            let set = Set(splitNum(inputNumber))
            
            return set.count == gameNumber   // Array를 Set으로 변환하여 중복을 제외한 값이 3이어야 함
            && Int(pow(10.0,Double(gameNumber - 1))) - 1 < inputNumber
            && inputNumber < Int(pow(10.0,Double(gameNumber)))
        }
        
        
        // MARK: - GameResult 구조체
        enum GameResult {
            case correct
            case nothing
            case progress(strike: Int, ball: Int)
        }
        
        
        // MARK: - 입력값과 정답을 비교해 힌트 계산하는 함수
        func compare(input: Int, with answer: [Int]) -> GameResult {
            var strike = 0
            var ball = 0
            let inputArray = splitNum(input) // 입력값을 쪼개서 세 원소를 가진 배열로
            
            // strike, ball에 결과값 입력
            for i in 0..<gameNumber {
                if inputArray[i] == answer[i] {
                    strike += 1
                } else if answer.contains(inputArray[i]){
                    ball += 1
                }
            }
            
            if (strike == gameNumber) {
                return GameResult.correct
            } else if (strike == 0 && ball == 0){
                return GameResult.nothing
            } else {
                return GameResult.progress(strike: strike, ball: ball)
            }
        }
    }
