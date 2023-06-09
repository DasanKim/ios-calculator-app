# 🧮 계산기

## 🎙️ 소개
`Dasan`이 만든 Queue 타입을 활용한 계산기입니다. 

<br>

## 📖 목차
1. [개발자](#-개발자)
2. [타임라인](#-타임라인)
3. [다이어그램](#-다이어그램)
4. [트러블 슈팅](#-트러블-슈팅)
5. [참고 링크](#-참고-링크)
6. [회고](#-회고)

<br>

## 👨‍💻 개발자
| Dasan |
|:-----:|
|<Img src="https://i.imgur.com/EU67fox.jpg" width="200"> |
|[Github Profile](https://github.com/DasanKim)|

<br>
  
## ⏰ 타임라인
|날짜|내용|
|:--:|:--|
|2023.05.29.(월)| - `Unit Test`공부<br> - 프로젝트를 시작하기 위한 git 셋업|
|2023.05.30.(화)| - `MVC모델`에 맞게 파일 구조 변경<br> - `Array queue` 구현<br> - `Array queue`에 대한 Unit Test<br> - LinkedList 자료구조 공부<br> - 계산기를 위한 queue class diagram 작성|
|2023.05.31.(수)| - `LinkedList queue`에 대한 Unit Test<br> - `LinkedList queue` 구현<br> - 자료구조와 상관없이(array, linkedList) queue 구조가 바뀌지 않도록 두 자료구조 내 property 통일<br> - class diagram 수정|
|2023.06.01.(목)| - `CalculateItem` 파일 분리<br> - test 네이밍 수정 및 test 상황 추가<br> - 피드백 요청사항 반영 및 전체적인 리펙토링 진행|
|2023.06.02.(금)| - queue의 맨 앞과 맨 뒤 값을 알 수 있는 `front`, `rear`프로퍼티 추가<br> - README 작성<br> |
|2023.06.05.(월)| - `Operator` 타입 구현 <br> - `Fomula`에 대한 Unit Test <br>  - `Formula` 타입 추가 및 `result` 메서드 구현 <br> - `ExpressionParser` 타입 생성 <br> - `CalculatorError` 타입 생성 <br> - 오류 처리를 할 수 있도록 코드 수정|
|2023.06.06.(화)| - `ExpressionParser`에 대한 Unit Test <br> - `ExpressionParser`의 내부 `parsing 하는 메서드` 구현 <br> - `String Extension` 파일 분리 <br> -  `Formula` 내 로직 수정 <br> - 전체적인 컨벤션 수정 |
|2023.06.07.(수)| - 새로운 그룹(폴더) 추가 및 파일 구조 수정 <br> - `Formula`의 `result` 메서드의 중복되는 조건문 수정 <br> - `componentsByOperators` 메서드가 String의 `split` 메서드를 활용하도록 수정|
|2023.06.08.(목)| - 피드백 요청사항 반영 및 전체적인 리펙토링 진행 <br> - `UILabel`의 text값이 `Operator`의 `빼기값`과 동일하도록 수정|
|2023.06.09.(금)| - UI와 코드 연결을 위한 고민 <br> - README 작성<br> |

<br>
  
## 📊 다이어그램
<p>
<img src ="https://github.com/DasanKim/ios-calculator-app/blob/step2/CalculateClassDiagram.png?raw=true" width="800">
</p>
  
<br>

## 🧨 트러블 슈팅

### 1️⃣ **삽입/삭제시 시간복잡도가 O(1)인 Queue 구현**

<details>
<summary>⚠️ 문제점</summary>

- `queue`를 구현하는 자료구조로 `Array`와 `LinkedList` 중 `LinkedList`를 선택하였습니다.
    - 그 이유는 `queue`는 `선입선출(FIFO)`의 자료구조로써 데이터가 **삽입되고 삭제되는 것**이 중요하기 때문에
    - 삽입/삭제시 시간 복잡도가 `O(n)`인 `Array` 대신
    - 삽입/삭제시 시간 복잡도가 `O(1)`인 `LinkedList`를 선택하였습니다.
- 노드를 추가해주는 `append` 메서드 부분을 `head` 프로퍼티만을 이용하여 작성하였더니, **노드의 next가 nil일 때까지 순회**하므로 Array의 시간복잡도 O(n)과 다를바가 없었습니다.

    ```swift
    // head만 있을 경우
    if isEmpty {
       head = Node(data: data)
       tail = head
    }

    var node = head
    while node?.next != nil {
       node = node?.next
    }
    node?.next = Node(data: data)

    ```
</details>

<details>
  <summary>✅ 해결방법</summary>

- `단일 LinkedList`지만 `LinkedList`의 처음과 마지막 노드인 `head`와 `tail` 프로퍼티를 추가하였습니다.
- `queue`는 `삽입`할 때는 `마지막 노드(tail)`를, `삭제`할 때는 `첫 노드(head)`만 알고 있으면 되기 때문입니다.
- `tail` 프로퍼티 덕분에, 노드를 추가할 때 끝까지 순회하지 않고 **바로 마지막 노드를 찾아갈 수 있었습니다.**

    ```swift
    // head와 tail이 있을 경우
    if isEmpty {
        head = Node(data: data)
        tail = head
    } else {
        let node = Node(data: data)
        tail?.next = node
        tail = node
    }
    ```
</details>
    
### 2️⃣ **Unit Test 활용하기**

<details>
<summary>⚠️ 문제점</summary>

- unit test에 익숙하지 못한 것도 있지만 이해를 잘 못했던 탓에 test를 하다보니 아래와 같은 문제가 발생했습니다.
  - mothod 이름에서 어떤 로직이 **이럴 때 어떻게 작동한다는 것**을 정확하게 알 수 없습니다.
  - mothod 이름 `test_뒤`에 어떤 기능 또는 어떤 mothod를 test하고 있는지 표기하지 않았습니다.
  - test mothod **위치가 논리적으로 어색**했습니다.
  - test가 **다양한 상황**에서 진행되고 있지 않았습니다.
    ```swift
        func test_노드의갯수를_올바르게_출력한다() {
            // given
            sut.append(1)
            sut.append(2)
            sut.append(3)
            sut.append(4)
            sut.append("+")
            sut.append("-")
            let expectation = 6

            // when
            let result = sut.count

            // then
            XCTAssertEqual(result, expectation)
        }
    ```
</details>
    
<details>
<summary>✅ 해결방법</summary>

- 리뷰어의 조언에 따라 문제점이었던 것들을 아래와 같이 수정하였습니다.
  - 로직이 **이럴 때 어떻게 작동한다는 것**을 method 이름에 나타내기
  - mothod 이름 `test_뒤`에 어떤 기능 또는 어떤 mothod를 test하고 있는지 표기하기
  - test mothod **위치를 논리적으로** 배치하기
  - test가 **다양한 상황**에서 진행하기
    ```swift

        func test_count_조건없이_queue의_count를호출할때_count는_0이다() {
            (내부구현 생략)
        }

        func test_count_queue_초기화시_head에_nil이들어갔을때_count는_0이다() {
            (내부구현 생략)
        }

        func test_count_queue_초기화시_head에_Node를넣었을때_count는_1이다() {
            (내부구현 생략)
        }

        // 이후 enqueue test 이후 아래 count test 실행

        func test_count_enqueue_1_2_3을했을때_count는_3이다() {
            // given
            sut.enqueue(1)
            sut.enqueue(2)
            sut.enqueue(3)
            let expectation = 3

            // when
            let result = sut.count

            // then
            XCTAssertEqual(result, expectation)
        }

        func test_count_enqueue_1_2_3을하고_dequeue를했을때_count는_2이다() {
            (내부 구현 생략)
        }
        
    ```
    
</details>

### 3️⃣ **각 타입들의 책임**

<details>
<summary>⚠️ 문제점</summary>

- 주어진 `UML`(위 class diagram 아님)을 보고 `ExpressionParser`와 `Formula` 타입의 `Property`, `Method`와 타입들 간의 `관계`를 통하여 타입마다 어떤 일을 하는지 유추해보았습니다. 하지만 내부 구현이 진행될수록 저도 모르게 **각 타입의 책임이 어디까지인지**를 잊고 진행하는 모습을 발견하였습니다.
- 특히 `ExpressionParser`는 `Formula`를 **의존**하고 있기 때문에, 연산할 수 없는 입력값(예를 들어 "+3"이나, "" 등)이 전달하였을 때 `어디서` `어떻게` 처리해주어야 하는지가 가장 큰 고민거리었습니다. 

</details>
    
<details>
<summary>✅ 해결방법</summary>
    
- 다시 한번 아래와 같이 각 타입들의 책임을 글로 적어보았습니다.

  - **ExpressionParser**: 표현식 구문 분석과 관련된 처리. 전달된 input값을 `분석`하여 `Formula타입`으로 변환하여 반환
  - **Formula**: 공식과 관련된 처리. `계산 가능한 공식`을 만들 수 있는지 확인한 후, 그 공식에 따른 `결과값`을 반환

- 이렇게 **글로 정리**해보니, 머릿속에 있었을 때보다 명확해지는 부분이 있었습니다. 따라서 `Formula`에서 공식을 만들 수 없는 값(연산할 수 없는 입력값)을 처리하는 것이 맞다고 생각하여 `Formula` 타입의 `result` 메서드 내에서 **조건문을 사용**하여 연산할 수 없는 입력값들을 처리하였습니다.
    
    
    ```swift
        struct Formula {
            var operands: CalculatorItemQueue<Double/>
            var operators: CalculatorItemQueue<Operator/>

            mutating func result() throws -> Double {
                guard var accumulatedValue = operands.dequeue() else {
                    throw CalculatorError.invalidOperation
                }

                while let rightValue = operands.dequeue(),
                      let currentOperator = operators.dequeue() {
                    accumulatedValue = try currentOperator.calculate(lhs: accumulatedValue, rhs: rightValue)
                }

                return accumulatedValue
            }
        }   
    ```

</details>

    
### 4️⃣ **오류처리**

<details>
<summary>⚠️ 문제점</summary>
    
- 아직 UI와 연동되지 않은 상태에서 Model 내부 로직의 `오류`를 `어디서` 처리해야하는지 고민이 되었습니다. 
- 이후 UI와 연결이 되고 ViewController 등에서 오류가 발생하였을 경우, Model과 Controller 내부에 오류를 각각 처리하기보다는 오류를 다루는 곳에서 한번에 처리하는 것이 좋다고 생각했으나 UI 연동까지 Model 내부의 오류 처리를 미룰 수는 없었습니다. 
    
</details>
    
<details>
<summary>✅ 해결방법</summary>
    
- 현재 오류를 던지기만 할 뿐 `do-catch문`이나 `try!`, `try?`으로 오류를 처리하지 않고 있습니다. 왜냐하면 현재 UI와 연결되지 않은 상태에서 `do-catch문`으로 할 수 있는 처리는 해당 오류를 잘 catch하여 **해당 오류에 대한 문구를 출력**하는 것인데 이것은 `XCTestCase`를 통해서도 충분히 확인할 수 있기때문입니다.
- 따라서 지금은 오류가 발생하면 `XCTestCase`에서 아래 메소드를 사용하여, 메소드 내의 `errorHandler`를 통해 오류를 handling하고 있습니다.
    
    ```swift
        XCTAssertThrowsError(try sut.result()) { error in
            XCTAssertEqual(error as! CalculatorError, CalculatorError.NotANumber)
        }
    ```

</details>

<br>

## 📚 참고 링크

- [🍎 Apple Docs: Array](https://developer.apple.com/documentation/swift/array)
- [🍎 Apple Docs: Set Up and Tear Down State in Your Tests](https://developer.apple.com/documentation/xctest/xctestcase/set_up_and_tear_down_state_in_your_tests)
- [🍎 Apple Docs: components](https://developer.apple.com/documentation/foundation/nsstring/1413214-components)
- [🍎 Apple Docs: xctassertthrowserror](https://developer.apple.com/documentation/xctest/1500795-xctassertthrowserror)
- [📄 WebPage: LinkedList](https://www.kodeco.com/books/data-structures-algorithms-in-swift/v3.0/chapters/6-linked-list)

 <br>
  
## 💭 회고
### 👏 칭찬할 부분
- 규칙적인 생활을 한 것

### 💪 개선해야할 부분
- 구현 전에 이유있는 코드를 위해 고민할 것
- 공식문서를 읽을 시간을 확보할 것
- 더 멀리가려고 하는 것이 아닌 주어진 하루에 집중할 것

