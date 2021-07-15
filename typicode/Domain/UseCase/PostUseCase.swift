//
//  PostUseCase.swift
//  typicode
//
//  Created by jinhyuk on 2021/07/13.
//

import Foundation
import RxSwift

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
