# ⚾ 숫자 야구 게임

숫자 야구 게임은 컴퓨터가 생성한 중복 없는 숫자를 맞히는 콘솔 기반 게임입니다.  
사용자는 숫자를 입력하고 **스트라이크 / 볼 / 아웃** 결과를 통해 정답을 추론합니다.

## 1. BaseballGame 타입 선택
### 1) Struct vs. Class
처음에는 구조체로 구현했으나, 내부 값을 계속해서 변경해나가야하는데 구조체는 그때마다 객체 자체를 다시 써야한다는 번거로움이 있습니다. (함수 앞에도 mutating 키워드를 계속 붙여줘야합니다.) 따라서 참조 타입인 클래스로 변경하였습니다.

### 2) hint 튜플
`hint`는 스트라이크와 볼로만 구분됩니다.
2개보다 더 많은 요소가 추가될 필요가 없고, 값에 이름을 붙여 직관적인 코드를 작성할 수 있다는 장점때문에 튜플을 선택하였습니다.

### 3) Menu 열거형
`selectMenu()` 함수의 `menu`는 `input`에서 공백만 제거한 문자열입니다. 처음에는 `start`와 `selectMenu` 함수를 분리하지 않았기에 문자열 그대로 분기처리하여 메뉴별 함수를 호출하였습니다.

(함수의 분리에 관한 내용은 2.2)에서 자세히 서술합니다.)

```swift
switch menu {
case "1":
    play()
case "2":
    record()
case "3":
    return
default:
    return
}
```

그러나 두 함수의 분리로 `menu`를 `selectMenu` 내부가 아닌 `start`에서도 사용하게 되었습니다.

`start`에서도 `menu`를 문자열 그대로 사용하여 분기처리할 경우 원하는 케이스 외에도 default를 정의해야 합니다. 게다가 열거형은 문자열보다 메모리를 덜 차지한다는 장점이 있으므로 여러 방면에서 열거형으로 사용하는 것이 적합하다고 생각하였습니다.

```swift
    func start() {
        while !isExit {
            ...
            
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
```

## 2. 함수의 분리
### 1) `getUserAnswer()`와 `checkAnswer()`
두 함수를 하나로 합쳐 구현할 수도 있었지만 (실제로 그렇게 구현하기도 했었지만) 유저의 정답을 얻는 것과 정답을 확인하는 것은 기능이 다르다고 생각하여 분리하였습니다.

`play()` 함수에서 함수들을 호출하여 사용하므로 게임의 흐름이 잘 보일 수 있도록 기능을 구분하여 구현하는 것이 적합하다고 생각했습니다.

### 2) `start()`와 `selectMenu()`
앞선 1.3)에서 언급했듯 처음에는 `selectMenu` 함수 없이 `start` 함수에서 `menu` 문자열을 그대로 분기처리하여 switch문에서 각 메뉴에 맞는 함수를 바로 실행하도록 하였습니다.

```swift
switch menu {
case "1":
    play()
case "2":
    record()
case "3":
    return
default:
    return
}
```

그러나 문제에서 각 메뉴가 실행된 후 '종료하기'를 제외하고는 실행 이후 다시 메뉴 선택 화면이 나오도록 요구하고 있습니다.

이를 충족하기 위해서는 '메뉴 선택'과 '게임 프로그램 시작' 기능을 분리해야한다고 생각했습니다. (정확히는, '메뉴 선택' 기능이 모듈화 되어야한다고 생각했습니다.)

```swift
    func start() {
        while !isExit {
            ...
                        
            guard let selected = selectMenu() else {
                print("유효하지 않은 입력입니다!")
                return
            }
            
            ...

        }
    }
```

따라서 `selectMenu` 함수를 분리하고 해당 함수를 통해 `menu`를 반환받아 `start`에서 분기처리하여 실행하는 방식으로 수정하였습니다.


## 3. 트러블 슈팅
### 1) 필수 구현 1번 - 중복 숫자가 포함되는 정답 생성
```swift
func setAnswer() {
    for _ in 0...2 {
        answer.append(Int.random(in: 1...9))
    }
}
```
문제 요구사항을 정독하지 않아 중복 숫자가 포함되는 정답을 생성하였습니다.

중복 숫자가 있는 경우, 힌트를 통해 유저가 올바른 정답을 떠올리기 어렵기 때문에 힌트의 의미가 사라집니다.

조건문을 추가하여 중복 숫자의 생성을 막아주었습니다.

### 2) 추가 구현 - 에러 핸들링 오류
유효하지 않은 값에 대한 오류를 여러번 다뤄야할 것 같아 에러 타입을 정의하였습니다.
```swift
enum GameError {
    case invalidInput
}
```

이후 함수 호출부에서 do-catch문으로 에러를 핸들링했으나 `GameError`에 정의된 에러 케이스를 모두 포함하였는데도 아래와 같은 오류가 발생하였습니다.

'Errors thrown from here are not handled because the enclosing catch is not exhaustive'

<img width="2158" height="436" alt="Image" src="https://github.com/user-attachments/assets/601ca043-fd3b-4fad-892c-a2430b9ae121" />

찾아보니 스위프트는 `throws`가 포함된 함수라면 '에러'를 던진다는 사실만 알지, 정확히 어떠한 에러를 던질지는 알 수 없다고 합니다.

따라서 `GameError`뿐만 아니라 (가능성은 매우 낮으나) 던져질 수 있는 정의되지 않은 다른 에러에 대해서도 처리를 해주어야 한다고 한다.

```swift
catch { 
    print("알 수 없는 오류입니다.")
}
```

default catch문을 작성해줌으로써 해결하였습니다.

+) **에러 타입이 지금 필요한가?**

앞서 유효하지 않은 값에 대한 오류를 여러번 다뤄야할 것 같아 에러 타입을 정의했다고 언급했습니다.

하지만 구현해나가다보니 생각보다 오류 케이스가 많지 않고(현재로써는 1개뿐), 그에 비해 default catch문을 포함한 do-catch문을 사용하기 위해 더 많은 코드가 작성된다고 여겨집니다.

따라서 나중을 대비해 에러 타입 자체는 남겨두고 함수는 throws를 하지 않도록 변경하였습니다.

예외 처리는 대부분 guard문을 통해 오류 내용을 출력하는 것으로 수정하였습니다.
