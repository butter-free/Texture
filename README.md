# Texture

> Texture 학습 진행 내용 및 예제

iOS에서의 일반적인 UI 구성 방법

* Storyboard 및 xib를 이용하여 구성요소(View) 작성 이후 constraint 적용
  * 장점
    > 구성된 화면이 한눈에 보이기 때문에 코드를 분석할때 도움이 된다.
    > View를 드래그 앤 드랍으로 빠르게 UI 개발이 가능하다.
    > Controller에 작성 될 코드를 줄일 수 있다.
  * 단점  
    > 파일만 열어도 내용(xml)이 변경되는 경우가 있으며 성능 이슈가 있다.
    > IBOutlet, IBAction 등의 연결이 하나라도 잘못된 경우 크래시 발생 등의 위험이 있다.

* 코드로 구성요소 작성 후 constraint 적용
  * 장점
    > 복잡한 레이아웃 및 다이나믹한 화면 처리에 Storyboard구성 보다 유용하다. (화면 파악 및 성능문제 등)
  * 단점  
    > UI 구성에서 View간 constraint 관계 파악이 쉽지 않다.
    > Storyboard, xib를 이용하는 것 보다 코드가 증가한다. (당연한 이야기 이지만...)

UI 구성 시 위와 같은 장단점에서 단점을 더 줄이기 위해서 Texture를 학습 하고자 한다.

Texture를 사용함으로 기대되는 효과

1. 작성되는 코드 수의 감소

2. 재사용성 증가 및 모듈화

3. 퍼포먼스(프레임드랍)에 대한 이득

4. RxSwift의 활용성 극대화

5. 파악이 보다 쉬운 코드 작성

---

## Step1

> 참고 및 예제 제공 사이트로 학습 진행

Texture에서는 Flex Box라는 것으로 레이아웃을 구성한다고 한다.
  
Flex Box를 학습하기위해 Raywendarich의 Yoga tutorial 예제 코드와 Yoga playground, Texture Guide 사이트 내용으로 먼저 학습을 진행하기로 한다.
  
> 제공된 Raywendarich tutorial 레이아웃이 별로 맘에들지 않았고, tabBar에 selected 프로퍼티에 따라서 빨간색 바가 적용되어야 하는데 적용되지 않는 버그가 있다 모두 수정해보자.

<details>
<summary>Flex Box</summary>
<div>

### Flex Box

* flex-direction

* justify-content

* align-items

* flex-glow

* flex-shrink

</div>
</details>

<details>
<summary>사이트 모음</summary>
<div>
  1. https://texture-kr.gitbook.io/wiki/ <br>
  2. https://www.raywenderlich.com/530-yoga-tutorial-using-a-cross-platform-layout-engine <br>
  3. https://yogalayout.com/playground <br>
  4. https://developer.mozilla.org/ko/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox
</div>
</details>