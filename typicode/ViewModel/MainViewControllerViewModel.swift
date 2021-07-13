//
//  MainViewControllerViewModel.swift
//  typicode
//
//  Created by jinhyuk on 2021/07/11.
//

import Foundation
import RxSwift

protocol MainViewControllerViewModelType {
  
  func testTab()
  
  var fetchDataSubject: PublishSubject<[Post]> { get }
}

class MainViewControllerViewModel: MainViewControllerViewModelType {
  
  var fetchDataSubject: PublishSubject<[Post]> = PublishSubject<[Post]>()
  
  private let disposBag: DisposeBag = DisposeBag()
  
  private let postUseCase: PostUseCase
  
  init(postUseCase: PostUseCase) {
    self.postUseCase = postUseCase
    
    self.postUseCase.getPosts()
      .subscribe(fetchDataSubject)
      .disposed(by: disposBag)
  }
  
  // test
  var change: Bool = false
  
  func testTab() {
    
    if change {
      change.toggle()
      BasicNetworkService().load(resource: ArrayAPIResource<Post>(requestAPIType: BasicAPIRequest.postsUID10))
        .subscribe(onNext: { posts in
          self.fetchDataSubject.onNext(posts)
//          self.fetchDataSubject.on(.next(posts))
        })
        .disposed(by: disposBag)
    }
    else {
      change.toggle()
      BasicNetworkService().load(resource: ArrayAPIResource<Post>(requestAPIType: BasicAPIRequest.posts))
        .subscribe(fetchDataSubject)
        .disposed(by: disposBag)
    }
    
  }
  
}
