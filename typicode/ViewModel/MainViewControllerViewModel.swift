//
//  MainViewControllerViewModel.swift
//  typicode
//
//  Created by jinhyuk on 2021/07/11.
//

import Foundation
import RxSwift

protocol MainViewControllerViewModelType {
  
  var fetchDataSubject: PublishSubject<[Post]> { get }
  
  // test Method
  func testTab()
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
  private var change: Bool = true
  func testTab() {
    if change {
      change.toggle()
      self.postUseCase.getPostsWithUID10()
        .bind(to: fetchDataSubject)
        .disposed(by: disposBag)
    } else {
      change.toggle()
      self.postUseCase.getPosts()
        .bind(to: fetchDataSubject)
        .disposed(by: disposBag)
    }
  }
}
