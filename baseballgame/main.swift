//
//  main.swift
//  aa
//
//  Created by 손영빈 on 1/15/26.
//

// Main 소스코드는 게임의 시작선택메뉴 나타내기 위한 객체와 실행을 위한 app인스턴스생성 및 실행을 위해 만들었습니다.
import Foundation

class Main{
    private var scoreRecord: [Int] = []
    private let game = Game()
    
    func startGame(){
        
        /* (Lv 4.) 1. 프로그램 시작 시 안내 문구 출력 */
        while true {
            print("""
                환영합니다! 원하시는 번호를 입력해주세요.
                1. 게임 시작하기 2. 게임 기록 보기 3. 종료하기
                """)
            guard let input = readLine()
            else { continue }
            
            switch input {
            /* (Lv 4.) 2. 게임 시작하기 선택 시 play로 연결 */
            case "1":
                let score = game.play()
                scoreRecord.append(score) // score을 Record에 저장
            /* (Lv 5.) 1. 게임 기록 보기 선택 시 시도 횟수 출력 */
            case "2":
                print("게임 기록 보기")
                for (idx, score) in scoreRecord.enumerated() { //고차함수 enumerated를 사용하여 idx: 인덱스 score: 점수 반환 후 출력
                    print("\(idx + 1)번째 게임 : 시도 횟수 - \(score)")
                }
                /* (Lv 6.) 1. 종료하기 선택 시 프로그램 종료(기록 초기화) */
            case "3":
                print("게임을 종료합니다.")
                return
                /* (Lv 6.) 2. 이외 입력값에 대한 오류 출력 */
            default:
                print ("올바른 숫자를 입력해주세요!")
            }
        }
    }
}

let app = Main()
app.startGame()
