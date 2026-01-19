# ⚾ 숫자 야구 게임

숫자 야구 게임은 컴퓨터가 생성한 중복 없는 숫자를 맞히는 콘솔 기반 게임입니다.  
사용자는 숫자를 입력하고 **스트라이크 / 볼 / 아웃** 결과를 통해 정답을 추론합니다.

---

## 개발 환경

- **Language**: Swift
- **IDE**: Xcode
- **Project Type**: Command Line Tool
- **Platform**: macOS

---

## 게임 규칙

- 컴퓨터는 게임 시작 시 **3자리 숫자**를 생성합니다.
- 3자리 숫자는 다음 규칙에 따라 만들어집니다.
  - 1~999 사이의 숫자
  - 두번째 자리와 세번째 자리는 0 숫자 포함 가능
  - 각자리의 숫자는 중복되지 않아야한다.
- 사용자는 중복 없는 3자리 숫자를 입력하여 정답을 맞춥니다.
- 판정 규칙:
  - **Strike**: 숫자와 자릿수가 모두 일치
  - **Ball**: 숫자만 일치, 자릿수 불일치
- **3 Strike**가 되면 게임 종료
- 게임 결과(시도 횟수)는 기록으로 저장됩니다.

---

## 프로젝트 구조
Baseball

├── Enum

- ├── EnumError.swift
  
- └── EnumMessage.swift

├── Function
- ├── FuncGamePlay.swift
  
- ├── FuncMenu.swift
  
- ├── FuncUtils.swift
  
- └── FuncViewRecord.swift
  
├── Model
- ├── ModelGameManager.swift
  
- └── ModelUser.swift
  
└── main.swift

---

## 구성 요소 설명

### Enum

#### EnumError
- 입력값 검증 및 메뉴 선택 오류 처리를 위한 열거형 선언

#### EnumMessage
- 게임 출력 메시지 중앙 관리

---

### Function

#### FuncMenu
- 프로그램 진입점
- 사용자 이름 입력
- 메인 메뉴 분기 처리

#### FuncGamePlay
- 실제 야구 게임 진행 로직
- Strike / Ball 판정 결과 처리

#### FuncUtils
- 입력 처리 유틸 함수

#### FuncViewRecord
- 사용자 게임 기록 출력
- 게임 횟수 및 시도 횟수 표시

---

### Model

#### GameManager
- 게임 관리자 역할 모델
- 중복 없는 랜덤 숫자 생성
- Strike / Ball 판정 로직 

#### User
- 사용자 이름 및 게임 기록 관리

---

## 핵심 구현 내용

- enum + Error 프로토콜을 활용한 명확한 에러 타입 분리
- throws / do-catch 구조를 이용한 에러에 대한 명확한 구분 처리 진행
- 구조 및 기능에 따른 파일 분리
- 게임 로직 책임 분산
  - 메뉴 (FuncMenu)
  - 게임 실행 (FuncGamePlay)
  - 입력 체크 (FuncUtils)
  - 기록 출력 (FuncViewRecord)
- 문자열 하드코딩을 제거하고 `EnumMessage`를 통한 메시지 중앙 관리
- 중복 없는 랜덤 숫자 생성 로직 구현
- Strike / Ball 판정 로직을 GameManager에 캡슐화
- 사용자 정보와 게임 기록을 User 모델에서 관리

---

## 실행 방법

1. Xcode에서 프로젝트 열기
2. Scheme을 **Command Line Tool**로 설정
3. `Run (⌘ + R)` 실행
4. 콘솔 안내에 따라 메뉴 선택 및 숫자 입력

