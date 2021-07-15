//
//  CommentReactor.swift
//  typicode
//
//  Created by jinhyuk on 2021/07/15.
//

import Foundation
import ReactorKit

protocol CommentViewControllerViewModelType {
  
  var fetchDataSubject: PublishSubject<[Comment]> { get }
  
}

class CommentViewControllerViewModel: CommentViewControllerViewModelType {
  
  var fetchDataSubject: PublishSubject<[Comment]> = PublishSubject<[Comment]>()
  
  private let disposBag: DisposeBag = DisposeBag()
  
  private let postUseCase: PostUseCase
  
  init(postUseCase: PostUseCase, post: Post) {
    self.postUseCase = postUseCase
    
    self.postUseCase.getCommentWithPostIndex(post.id)
      .subscribe(fetchDataSubject)
      .disposed(by: disposBag)
  }
  
  

  
}
