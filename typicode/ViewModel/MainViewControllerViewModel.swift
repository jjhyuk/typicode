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
  var transitionViewSubject: PublishSubject<Post> { get }
}

class MainViewControllerViewModel: MainViewControllerViewModelType {
  
  var fetchDataSubject: PublishSubject<[Post]> = PublishSubject<[Post]>()
  
  var transitionViewSubject: PublishSubject<Post> = PublishSubject<Post>()
  
  private let disposBag: DisposeBag = DisposeBag()
  
  private let postUseCase: PostUseCase
  
  init(postUseCase: PostUseCase) {
    self.postUseCase = postUseCase
    
    self.postUseCase.getPosts()
      .subscribe(fetchDataSubject)
      .disposed(by: disposBag)
    
    self.transitionViewSubject
      .bind(onNext: self.viewChange)
      .disposed(by: disposBag)
  }
  
  func viewChange(_ post: Post) {
    print("View Transition")
    print(post.id)
    print(post.userId)
    print(post.title)
    print(post.body)
    
    let vc: CommentViewController = CommentViewController(post)
    UIApplication.shared.keyWindow?.rootViewController?.present(vc, animated: true, completion: nil)
  }
}
