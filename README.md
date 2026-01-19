# ⚾ 숫자 야구 게임

숫자 야구 게임은 컴퓨터가 생성한 중복 없는 숫자를 맞히는 콘솔 기반 게임입니다.  
사용자는 숫자를 입력하고 **스트라이크 / 볼 / 아웃** 결과를 통해 정답을 추론합니다.

----------

## 1. 프로젝트 소개
### 1) 프로젝트 구조
```swift
├── Controller
│   ├── GameController.swift // 게임 시스템 관리
│   ├── GameComputer.swift // 게임 연산 담당
│   ├── InputManager.swift // 유저 입력 및 검증 담당
│   └── RecordManager.swift // 기록 관리 담당
├── Helper
│   ├── GameMessage.swift // 게임 메세지 문자열
│   └── Helper.swift // 부가적으로 필요한 열거형
├── main.swift
├── Model
│   ├── CheckResult.swift // 정답 확인 결과 모델
│   └── Record.swift // 게임 기록 모델
└── View
    └── MessagePrinter.swift // 게임 메세지 출력 담당
```

객체화를 진행하며 기능에 따라 객체들을 분리하다보니 MVC 패턴으로 구분지어봐도 될 것 같아 시도해보았습니다.

- **Model** : 게임 내에서 데이터로 사용될 객체
- **View** : 게임 UI 관련 객체
- **Controller** : 게임 시스템 관련 동작 객체
- **Helper** : 위 3가지 분류에 해당되지 않는 부가 객체

위 기준으로 분리하였습니다.

각 Controller와 View 객체는 만약 이 프로젝트가 커진다고 가정했을 때, 재사용성을 고려하면 프로젝트의 여러 곳에서 동일한 하나의 객체를 가리키게 하는 편이 낫지않을까 생각하여 클래스로 구현하였습니다.

### 2) 설계 시 고려했던 부분
**GameController 클래스**
<img width="1044" height="856" alt="Image" src="https://github.com/user-attachments/assets/75f28f9a-7d6a-40ae-9d71-071db447a5ba" />

게임의 전체적인 시스템을 관리하는 클래스입니다.

각 기능을 담당하는 클래스에게 명령을 내려 핵심 기능을 수행하게 합니다.

내부에서 다른 Controller 클래스들을 참조하기도 하고, 실제 개발 환경이었다면 `GameController`이라는 부모 클래스를 상속받아서 `BaseballGameController`이라는 클래스가 생성될 수도 있지 않을까 생각하여 클래스로 구현하였습니다.

- `selectMenu()`, `play()`, `showRecord()`, 
: 메뉴를 선택하고 각 메뉴의 기능을 동작하는 함수입니다.
 
 GameController는 각 클래스들을 모아서 동작을 명령하고 게임을 주도하는 관리자같은 존재입니다.
 
 따라서 게임 진행과 관련있는 기능들은 GameController 내에서 구현되어야 GameController가 게임을 주도할 수 있다고 생각했습니다.
 
 그때문에 메인 메뉴의 기능을 동작하는 함수를 GameController에서 선언하고, 함수 내부에서 기능을 구현하기 위해 각 클래스로의 동작을 명령합니다.
 
 즉, 해당 함수들은 클래스로의 일종의 동작 명령 모음인 셈입니다.

- `getUserAnswer() -> [Int]`
: 처음에는 GameComputer내에 선언되었던 함수입니다.

하지만 GameComputer에서 함수가 동작하기 위해서는 GameComputer내에서 inputManager와 messagePrinter가 동작해야합니다.

게다가 GameComputer는 연산만을 담당하는 클래스인데, 해당 동작은 연산이 아닌 유효한 유저 입력값을 반환하는 것이 목적이라 클래스의 기능과는 맞지 않다고 생각했습니다.

GameController는 관리자로써 각 Controller 클래스를 연결해주는 중재자(매개체)로서의 기능도 하고있습니다.

`getUserAnswer` 함수는 InputManager로부터 입력값을 받아 다른 클래스로 전달하기 위해 사용됩니다.

따라서 이는 GameController가 담당할 기능이라 생각하여 해당 클래스 내에 구현하게 되었습니다.
 
**GameComputer 클래스**
 <img width="1044" height="496" alt="Image" src="https://github.com/user-attachments/assets/32f044aa-4d6a-4dc9-b198-29091f115055" />
 
 게임 관련 연산을 담당하는 클래스입니다.
 
- `setAnswer() -> [Int]`

처음에는 for문을 활용해 정답을 생성하였습니다.

```swift
func setAnswer() {
    let answer = []

    for _ in 0...2 {
        // 정답 첫 번째 숫자일 경우
        if answer.isEmpty {
            let num = Int.random(in: 1...9)
            answer.append(num)
        } else {
            var num = Int.random(in: 0...9)
            // 정답에 포함되어있다면 num 재생성
            while answer.contains(num) {
                num = Int.random(in: 0...9)
            }
            answer.append(num)
        }
    }
}
```

이후 튜터님께서 `shuffle()` 메서드를 활용해볼 것을 제안하셔서 적용해보았습니다.

```
func setAnswer() {
    ...
    
    var num = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9] // 정답 숫자 후보
    num.shuffle() // 숫자 배열 섞기
    answer = num[0] != 0 ? Array(num[0...2]) : Array(num[1...3]) // 첫 번째 숫자가 0일 경우 예외 처리
}
```

`num` 배열을 생성하여 코드를 작성했는데, 생성하지 않고도 메서드를 활용해 바로 정답 배열을 만들 수 있다는 피드백을 들어 다시 수정하였습니다.

```func setAnswer() -> [Int] {
    return Array((0...9).shuffled()
            .trimmingPrefix(while: { $0 == 0 }).prefix(3)
}
```

`trimmingPrefix(while:)`을 활용하여 `(0...9).shuffled()`의 첫 요소가 0일 경우 0을 잘라내고 첫 3개의 요소를 바로 반환하도록 하였습니다.

 
**RecordManager 클래스**
<img width="4244" height="1656" alt="Image" src="https://github.com/user-attachments/assets/3161f93e-bc3e-4b6a-b6e6-aafc91188f64" />

게임 기록을 관리하는 클래스로, 싱글톤 패턴을 사용해보았습니다.

게임 기록은 야구 게임 내에서 유일한 기록입니다. 따라서 해당 기록을 변경시키는 존재 또한 유일해야한다고 판단하여 싱글톤 패턴을 적용해보았습니다.

**Record 클래스**

게임 기록 그 자체를 의미하는 클래스입니다.

RecordManager와 같은 이유로, 생성된 **하나의** 게임 기록이 지속해서 변화해야한다고 생각했으므로 게임 기록 모델인 `Record` 또한 클래스로 구현해보았습니다.

클래스 내부의 `attempts`는 한 게임 라운드의 시도 횟수를 저장하는 배열입니다.

처음에는 `round`와 `attempts`를 `[Int: Int]` 형태의 딕셔너리로 구현하려했으나, key 값으로 쓰일 `round`는 단순 숫자이므로 key로써의 의의가 떨어진다고 판단했습니다.

특정 라운드의 기록을 랜덤하게 불러오는 것이 아니기 때문에 순서대로 값이 저장되는 배열이 게임 기록을 저장하기에 적합한 타입이라 생각했습니다.

이후 특정 게임 기록이 필요하더라도, key값이 단순 숫자인 이상 인덱스로 값을 불러오는 배열과 딕셔너리가 기능 면에서 차이가 없을거라 생각했습니다.

오히려 배열이 key의 hash 값을 찾을 필요가 없기 때문에 성능면에서도 우위가 있으리라 판단하여 배열을 사용했습니다.

## 2. 트러블 슈팅
### 1) 필수 구현 1번
#### ⚠️ 문제: 중복 숫자가 포함되는 정답 생성
```swift
func setAnswer() {
    for _ in 0...2 {
        answer.append(Int.random(in: 1...9))
    }
}
```
→ 중복 여부를 확인하지 않고 랜덤 숫자를 생성하고 있음

#### ❗️ 원인: 중복 생성 방지 코드의 부재
문제 요구사항을 정독하지 않아 중복 숫자 생성을 막는 코드를 작성하지 못했습니다.

중복 숫자가 있는 경우, 힌트를 통해 유저가 올바른 정답을 떠올리기 어렵기 때문에 힌트의 의미가 사라집니다.

#### ✅ 해결: 조건문 추가
```swift
while answer.contains(num) {
    num = Int.random(in: 0...9)
}
answer.append(num)
```

조건문을 추가하여 중복 숫자의 생성을 막아주었습니다.

### 2) 추가 구현
#### ⚠️ 문제: 에러 핸들링 오류
유효하지 않은 값에 대한 오류를 여러번 다뤄야할 것 같아 에러 타입을 정의하였습니다.

```swift
enum GameError {
    case invalidInput
}
```

이후 함수 호출부에서 do-catch문으로 에러를 핸들링했으나 `GameError`에 정의된 에러 케이스를 모두 포함하였는데도 아래와 같은 오류가 발생하였습니다.

'Errors thrown from here are not handled because the enclosing catch is not exhaustive'

<img width="2158" height="436" alt="Image" src="https://github.com/user-attachments/assets/601ca043-fd3b-4fad-892c-a2430b9ae121" />

#### ❗️ 원인: default 에러 핸들링 코드의 부재

찾아보니 스위프트는 `throws`가 포함된 함수라면 '에러'를 던진다는 사실만 알지, 정확히 어떠한 에러를 던질지는 알 수 없다고 합니다.

따라서 제가 던졌던 `GameError`뿐만 아니라 (가능성은 매우 낮으나) 던져질 수 있는 정의되지 않은 다른 에러에 대해서도 처리를 해주어야 한다고 합니다.

#### ✅ 해결: default 핸들링 코드 작성

```swift
do {
    try getUserAnswer()
} catch GameError.invalidInput {
    print("유효하지 않은 입력입니다!")
} catch { // default 핸들링 코드 작성
    print("알 수 없는 오류입니다.")
}
```

default catch문을 작성해줌으로써 해결하였습니다.

### 3) 추가 구현
#### ⚠️ 문제: 가변 문자열의 열거형 케이스 구현 어려움

기존 직접 입력하여 출력하던 문자열들을 열거형 타입 하나로 묶어 열거형을 호출해 출력하는 방식으로 리팩토링을 시도했습니다.
```swift
enum GameMessage: String {
    case welcome = "환영합니다!" // 설명을 위해 출력값 간소화
    ...
}

그 과정에서 `hint(strike: Int, ball: Int)` 값에 따라 다른 값을 출력하던 문자열 부분에서 어려움을 겪었습니다.

```swift
// 기존 힌트 출력 코드
if hint.strike == 3 {
    isCorrect = true
    print("🎉 정답입니다!\n")
} else if hint.strike == 0 && hint.ball == 0 {
    print("❌ Nothing\n")
} else {
    // 문제의 출력문
    print("🎯 \(hint.strike) 스트라이크 ⚾️ \(hint.ball) 볼 입니다!\n")
}
```

#### ❗️ 원인: 열거형의 문자열 원시값 정의

`GameMessage` 케이스 별로 다른 연관값을 주어 해결하고자 했지만, 그 경우에는 외부에서 열거형 객체를 생성해주어야한다는 단점이 있었습니다.

```swift
enum GameMessage {
    case welcome (String)
    case hint (strike: Int, ball: Int)
}

// 문자열을 사용하려면 별도 객체 생성 필요
let message = GameMessage.welcome("환영합니다!")
```

위 방법은 케이스 별로 객체를 생성해주어야하므로 번거롭다고 생각했습니다.

따라서 별도의 `Hint` 열거형을 생성하여 1차적으로 해결은 했습니다.

```swift
enum Hint {
    case hint(strike: Int, ball: Int)
    
    func toString() -> String {
        switch self {
        case .hint(let s, let b):
            return "(s) 스트라이크 \(b) 볼 입니다\n"
        }
    }
}

let m = Hint.hint(strike: hint.strike, ball: hint.ball)
print(m.toString()) // "n 스트라이크 n 볼 입니다" 출력
```

위처럼 구현하면 돌아가기는 하지만... 좀더 간결한 방법은 없을까 싶어 튜터님께 조언을 구했습니다.

#### ✅ 해결 방법1: 확장과 프로토콜 활용하기
```swift
enum GameMessage {
    case welcome
    case hint(strike: Int, ball: Int)
}

extensionSystemMessage: CustomStringConvertible {
    var description: String {
    switch self {
    case .welcome: return "환영합니다!"
    case .hint(let s, let b):
        return s == 3 ? "🎉 정답입니다! 🎉"
            : s == 0 && b == 0 ? "❌ Nothing\n" :
            "🎯 \(s) 스트라이크 ⚾️ \(b) 볼 입니다!\n"
    }
}
```

`GameMessage`를 확장하여 `CustomStringConvertible` 프로토콜을 채택하는 방법입니다.

`CustomStringConvertible` 프로토콜은 `description` 변수를 정의하여 케이스 별로 문자열 값을 사용 가능하도록 하는 프로토콜입니다.

여기서 정의한 `description`의 값은 String Interpolation으로 열거형 타입을 사용할 때 `description`에 접근할 필요 없이 자동으로 치환되어 사용됩니다.

```swift
print("\(GameMessage.welcome)") // "환영합니다!" 출력
```

#### ✅ 해결 방법2: 타입 변수 활용하기
```swift
enum GameMessage {
    static var welcome = "환영합니다!"
    static var hint = ""
    
    static func getHint(for s: Int, _ b: Int) {
        hint = s == 3 ? "🎉 정답입니다! 🎉"
            : s == 0 && b == 0 ? "❌ Nothing\n" :
            "🎯 \(s) 스트라이크 ⚾️ \(b) 볼 입니다!\n"
    }
}
```

`enum` 혹은 `struct` 타입에 타입 변수와 타입 메서드를 활용하는 방법입니다.

타입을 선언하고 확장해줄 필요 없이 한 번에 선언 가능하다는 장점이 있습니다.

`GameMessage`는 별도 객체를 생성할 필요가 없기 때문에 열거형 타입으로 선언하였습니다.

➡︎ 처음에는 1번 방법처럼 확장하여 프로토콜을 활용했으나, 코드를 더 간략히 작성하기 위해 2번 방법으로 변경하여 열거형 내에서 타입 변수를 활용하였습니다.
