//
//  PostRepo.swift
//  typicode
//
//  Created by jinhyuk on 2021/07/13.
//

import Foundation
import RxSwift

protocol PostRepoProtocol {
  func getPosts() -> Observable<[Post]>
  func getPostsUID10() -> Observable<[Post]>
  
  func getCommentWithPostIndex(_ index: Int) -> Observable<[Comment]>
}

class PostRepo: PostRepoProtocol {
  
  func getPosts() -> Observable<[Post]> {
    BasicNetworkService().load(resource: ArrayAPIResource<Post>(requestAPIType: BasicAPIRequest.posts))
      .catchAndReturn([])
  }
  
  func getPostsUID10() -> Observable<[Post]> {
    BasicNetworkService().load(resource: ArrayAPIResource<Post>(requestAPIType: BasicAPIRequest.postsUID10))
      .catchAndReturn([])
  }
  
  func getCommentWithPostIndex(_ index: Int) -> Observable<[Comment]> {
    BasicNetworkService().load(resource: ArrayAPIResource<Comment>(requestAPIType: BasicAPIRequest.commentWtihPostIndex(index)))
      .catchAndReturn([])
  }
}

