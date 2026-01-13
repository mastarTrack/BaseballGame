// 3자리 난수 생성 함수(1~9) -> Set 사용 -> 문제점 : 정답 생성용 Set, 정답 저장용 Array가 별도로 필요함.
func randomAnswer()-> [Int]{
    var answer: Set<Int> = []
    var result: [Int] = []

    /* (Lv.1) 1. 1~9 서로 다른 난수 3개 생성 */
    while answer.count < 3 { //정답 생성용(Set 사용) : 같은 수 반복 x
        let num = Int.random(in: 1...9)
        answer.insert(num)
    }
    result = Array(answer) // 정답 저장용
    print(answer)
    print(result)
    return result
}
/* (Lv 3.) 1. 첫 자리(1~9), 나머지(0~9): Set 사용하지 않고 contains로 조건 사용 */
func randomAnswer2()-> [Int]{
    var result: [Int] = []

    let fst = Int.random(in: 1...9)
    result.append(fst)
    while result.count < 3{
        let rndnum = Int.random(in: 0...9)
        if !result.contains(rndnum){
            result.append(rndnum)
        }
    }
    print(result)
    
    return result
}

// 프로그램 시작 함수
func startGame(){
    
    var scoreRecord: [Int] = []
    /* (Lv 4.) 1. 프로그램 시작 시 안내 문구 출력 */
    while true{
        print("""
            환영합니다! 원하시는 번호를 입력해주세요.
            1. 게임 시작하기 2. 게임 기록 보기 3. 종료하기
            """)
        guard let input = readLine()
        else {continue}
        
        switch input {
        /* (Lv 4.) 2. 게임 시작하기 선택 시 play로 연결 */
        case "1":
            let score = play() //게임 후 결과를 Int로 반환받아서 score에 할당
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
// 게임 시작 함수
func play()-> Int{
    
//    let result = randomAnswer()
    let result = randomAnswer2()
    var totalCount = 0
    while true{
        /* (Lv.2) 1. 정답 맞추기 + 힌트 받기 */
        print("숫자를 입력하세요: ", terminator: "\n")
        guard let input = readLine(),
              let num = Optional(input.map{Int(String($0))}), //숫자 외의 다른 값이 들어왔는지 확인, map 대신 compactMap 사용 : map -> 이후 nil 처리 필요
              num.count == 3
        else {
            print("올바르지 않은 입력값입니다.")
            continue
        }
        
        if Set(num).count != 3 { //중복된 값이 있는지 확인
            print("올바르지 않은 입력값입니다.(중복)")
            continue
        }
        
        totalCount += 1
        
        let inputChars = Array(input) //입력받은 값을 배열에 담음
        
        /* (Lv.2) 2. 힌트 생성, 게산 */
        var strike: Int = 0
        var ball: Int = 0
        
        for i in 0..<3 {
            if result[i] == Int(String(inputChars[i]))! { //Int는 Character를 바로 받지 못함 -> String으로 감싸기
                strike += 1
            } else if result.contains(Int(String(inputChars[i]))!) {
                ball += 1
            }
        }
        if strike == 3{
            print("정답입니다.")
            return totalCount//정답일 경우, 게임 종료 -> (break를 사용하지 않고 return을 사용한 이유 -> 기록을 남기기 위해서)
        }else if strike >= 1 && ball >= 1{
            print("\(strike)스트라이크 \(ball)볼")
        }else if strike >= 1 {
            print("\(strike)스트라이크")
        }else if ball >= 1 {
            print("\(ball)볼")
        }else {
            print("Nothing")
        }
        
    }
}

startGame()
