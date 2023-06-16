# 계산기 II

## 🍀 소개
`Dasan`과 `Zion`이 만든 계산기입니다. 사용자로부터 UI 입력을 받아 계산기 동작을 수행합니다.

<br>

## 📖 목차
1. [팀원](#-팀원)
2. [타임라인](#-타임라인)
3. [시각화된 프로젝트 구조](#-시각화된-프로젝트-구조)
4. [실행 화면](#-실행-화면)
5. [트러블 슈팅](#-트러블-슈팅)
6. [참고 링크](#-참고-링크)

<br>

## 👨‍💻 팀원
| Dasan | Zion |
| :------: | :------: |
|<Img src="https://i.imgur.com/EU67fox.jpg" width="200" height="200"> |<Img src="https://hackmd.io/_uploads/rJqMfSoVn.png" width="200" height="200"> |
|[Github Profile](https://github.com/DasanKim) |[Github Profile](https://github.com/LeeZion94)

<br>

## ⏰ 타임라인
|날짜|내용|
|:--:|--|
|2023.06.12.(월)| - `메모리 구조` 및 `ARC`에 관한 학습 <br> - **Dasan**: STEP3 계산기 코드와 UI 연동(with `Zion`) | 
|2023.06.13.(화)| - **Dasan**: STEP3 계산기 `예외처리`(with `Zion`)  <br> - **Zion**: STEP3 `리팩토링` | <br> - **Zion**: `Protocols`, `Extensions` 공식문서 학습 |
|2023.06.14.(수)| - **Dasan**: STEP3 계산기 `예외처리`(with `Zion`) <br> - **Zion**: `Generics` 공식문서 학습 | 
|2023.06.15.(목)| - `iOS App Life Cycle`에 관한 학습 <br> - Dasan과 Zion 계산기 코드 PR을 통한 **병합** <br> - 병합한 코드 **리팩토링** <br> - `PR` 작성 |
|2023.06.16.(금)| - 피드백 요청사항 반영 및 전체적인 리팩토링 <br> - `README` 작성 |

</br>

## 👀 시각화된 프로젝트 구조

<p>
<img width="" src="https://github.com/DasanKim/ios-calculator-app/blob/calculator2-Step2/Calculate2ClassDiagram.jpg?raw=true">
</p>
<br>

## 💻 실행 화면 
|입력을 받은 수 계산화면|소수점 입력을 받은 수 계산화면|
|:--:|:--:|
|<img src="https://hackmd.io/_uploads/ryrYSutvn.gif" width="400">|<img src="https://hackmd.io/_uploads/H1jZLdFv3.gif" width="400">|

|이전 결과값에 이어서 계산하는 화면|AllClear로 결과값을 전부 지우는 실행화면|
|:--:|:--:|
|<img src="https://hackmd.io/_uploads/BJQ7UdYv3.gif" width="400">|<img src="https://hackmd.io/_uploads/Hy6XUOKwh.gif" width="400">|

</br>

## 🧨 트러블 슈팅

### 1️⃣ **UI를 갱신하는 타이밍 고민** <br>

🔒 **문제점** <br>
계산기의 계산식이 추가될 때마다 ScrollView내부의 StackView에 계산식이 쌓이고 늘어난 Scroll ContentSize에 ScrollToBottom을 해주는 로직을 추가했습니다.

하지만, 계산식이 추가되어 스크롤이 될 때마다 한 개의 계산식 만큼 밀려서 스크롤이 되는 현상이 이슈로 나타나게되었습니다.

🔑 **해결방법** <br>
원인은 UI의 갱신 타이밍이었습니다. ScrollView내부의 StackView에 계산식이 쌓이고 늘어난 ScrollView에 대해 ScrollToBottom이 되어야 했지만 늘어나기 이전의 ContentSize를 기준으로 ScrollToBottom 동작을 하게되어 해당 이슈가 발생했습니다.

따라서, 해당 이슈를 해결하기 위해 UI를 갱신하기 위한 메서드들을 살펴봤습니다.
정리한 내용을 같이 공유드립니다! [UI 갱신 메서드 비교](https://medium.com/@LeeZion94/layoutifneeded-vs-setneedslayout-23a29471582a)


### 2️⃣ **비슷한 기능 및 역할을 하는 객체의 네이밍에 대한 고민** 

🔒 **문제점** <br>
소수점, 정수, operand, operator와 같이 비슷한 기능 및 역할을 하지만 조금씩은 다른 특징을 가지는 객체에 대한 네이밍을 정하는데 있어서 많은 어려움이 있었습니다. 따라서 이러한 것들이 쌓이다보니 나중에는 해당 객체가 어떤 역할을 하는지 한번 더 생각해야하는 고민이 늘게 되었습니다.

🔑 **해결방법** <br>
우선 해당 객체의 네이밍의 범위를 해치지 않는 선에서 통합할 수 있는 기능 및 역할들을 통합했습니다. 또한 분명하게 구분지어져야하는 property 및 method에 대해서는 네이밍이 조금은 더 길어지더라도 분명하게 역할이 나누어질 수 있도록 키워드를 추가하여 작성했습니다. Swift Language Guide에서도 언급하고 있듯이 간결함 보다는 명료함에 초점을 맞춘 네이밍을 가져가고자 했습니다.

그 결과, 계산기의 기능 및 동작을 하는데 있어서 역할의 분명함 뿐만 아니라, 역할에 따라 나누다 보니 했던 개체들의 기능분리를 통해 프로그램의 전체적인 가독성의 상승과 유지보수성이 좋아지게되었습니다.

<br>

## 📚 참고 링크
- [Blog: UI 갱신 타이밍](https://ontheswift.tistory.com/20)
- [Blog: UIScrollView Layout](https://beepeach.tistory.com/613)
- [Blog: Floating Point](https://serynana.tistory.com/entry/swift-%EB%B6%80%EB%8F%99-%EC%86%8C%EC%88%98%EC%A0%90-%EC%98%A4%EB%A5%98%EA%B0%80-%EB%82%98%EB%8A%94-%EC%9D%B4%EC%9C%A0)
- [Blog: Liked-List](https://opentutorials.org/module/1335/8821)
- [Apple Docs: double](https://developer.apple.com/documentation/swift/double)

<br>
