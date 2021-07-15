# RxSwift, RxAlamofire + Clean Archtecture 맛보기

반응형 프로그래밍에서 [RxSwift](http://reactivex.io/) 를 가볍게 사용해보고, Rx로 이루어진 RxAlmofire 와 함께 
Clean Archtecture를 적용해보는 프로토 타입을 만들어 보았다.
아래 사용될 샘플의 RestAPI는 https://jsonplaceholder.typicode.com/ 해당 주소에서 사용하였다.



### RxSwift란?

''관찰 가능한 시퀀스를 사용하는 이벤트 기반의 프로그래밍을 위한 라이브러리다입니다' 라고 공식 홈페이지에 명시되어 있다. 
시퀀스는 아래와 같이 ''Marble Diagram' 이라고 표현하여, Operator에 따라 데이터가 어떻게 흘러갈 수 있는지 보여주는 다이어그램이다. 처음볼 땐 굉장히 어색한 느낌이 들었지만, 보다 보니 시퀀스의 의미를 너무 잘 표현한거로 느껴진다.

<img title="" src="S.PublishSubject.png" alt="S.PublishSubject.png" data-align="inline">

오늘 샘플에서 사용할 PublishSubject이다. 
구독을 하더라도, 다음 이벤트까지 아무것도 주지 않는다는 것을 표현 다이어그램이다. 
텍스트로만은 와닿지 않았기에 간단하게 샘플 작성해보며 느낀 점을 적어보려 한다.

##### TableView Example

```swift
// 1
viewModel.fetchDataSubject
  // 2
  .bind(to: tableView.rx.items) { tableView, row, item in
    // 3
    let cell = tableView.dequeueReusableCell(withIdentifier: "test") as! PostCell
    cell.configureWith(item)
    return cell
  }
  .disposed(by: disposeBag)


// 4
tableView.rx.modelSelected(Post.self)
  .do { _ in
    self.tableView.indexPathsForSelectedRows?.forEach {
      self.tableView.deselectRow(at: $0, animated: true)
    }
  }
  // 6
  .subscribe(viewModel.transitionViewSubject)
  .disposed(by: disposeBag)
```

1) ViewModel의 fetchDataSubject의 데이터를 관측한다. (= 값을 가져오고, 값이 변함에 따라서 변한다.)

2) 관측 중인 데이터를 기반으로 TableView를 구성한다.

3) 기본적인 TableViewCell을 정한다. 
   기본 iOS에선 Datasource/ Delegate를 선언하였지만, 그런 불편함이 사라졌다.
   또한 데이터가 잘 흐르고 있다면, TableView도 자동으로 갱신돤다.  ReloadData를 호출할 필요 없음

4) 아까완 다른게 주체가 TableView로 바뀌었고. modelSelected를 통해, 클릭된 Cell의 정보를 가져온다. 

5) 클릭된 Cell의 정보를 가져와 ViewModel 의 transitionViewSubject에게 값을 전달한다. 



간단하게 RxSwift를 사용해보면서, 더 잘 사용하기엔 어려움이 있지만, '데이터 흐름''이라는 관점에서 바라보고 잘 흐를 수 만 있다면, 정말 편한 라이브러가 될꺼 같다고 느낀다.



### Clean Architecture

![CleanArchtecture.jpeg](CleanArchtecture.jpeg)

클린 아키텍쳐라고 대표적인 그림을 가져왔다. Rx와 마찬가지로 나에게 있어서 해당 그림만으로 단번에 이해하기 굉장히 어려웠다. 하지만 이해했던 내용을 먼저 정리하고 샘플앱을 확인하려 한다. 

##### Entities

 기본적인 데이터의 구조 ( = 나에게 있어 Model 클래스라고 명칭하는게 더 이해하기 쉬웠다. 

아래와 같은 코드 구조를 가진다. 

```swift
struct Post: Codable {
  let userId: Int
  let id: Int
  let title: String
  let body: String
}

...

struct Comment: Codable {
  let postId: Int
  let id: Int
  let name: String
  let email: String
  let body: String
}

```

##### UseCases

Application 내 에서 사용하는 로직을 담당한다. 

예제가 조금 아쉬운 점이 특별한 로직 자체가 아니라 get 메소드로으로 API 호출하여 데이터를 가져오는 역할만 한다는게 아쉽다. 

```swift
class PostUseCase {
  
  private final let postRepo: PostRepoProtocol
  
  init(postRepo: PostRepoProtocol) {
      self.postRepo = postRepo
  }
  
  func getPosts() -> Observable<[Post]> {
    postRepo.getPosts()
  }
  
  func getPostsWithUID10() -> Observable<[Post]> {
    postRepo.getPostsUID10()
  }
  
  func getCommentWithPostIndex(_ index: Int) -> Observable<[Comment]> {
    postRepo.getCommentWithPostIndex(index)
  }
}
```

실제로 앱에선 이 부분에서 로직 처리가 진행되어야 한다. 



##### Controllers

UI와 관련된 역할을 담당한다. 




Clean Architecture를 보고 대표적으로 느낀 점이 있다. 

1. 최대한 책임을 분리한다. = 각 계층은 한가지 역할만 한다. 

2. 안쪽 원은 바깥쪽 원에 의존성이 절대 걸려선 안된다. 

3. 가장 안쪽에 있는 Entity 부터 바깥 원으로 나올수록, 변하지 않는 구조에서 변할 수 도 있는 구조 = ex, 서버 통신 후 데이터를 구성하는 모델 클래스는 최대한 변하지 않지만, UI는 충분히 상황에 따라 변할 수 있다. 

다른 디자인 패턴도 그렇지만, 정말 기본적으로 아키텍쳐의 그림을 제시해 준거 같다. 



각 개발 스타일마다 다르겠지만, 역할이 분명한 모듈화 규칙을 통해 팀원 모두가 같은 스타일로 작업 할 수 있다면 MVP, MVVM, VIPER, VIP 등 디자인 패턴을 적용하면 좋을꺼같다. 





