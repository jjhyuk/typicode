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
}

class PostRepo: PostRepoProtocol {
  
  func getPosts() -> Observable<[Post]> {
    BasicNetworkService().load(resource: ArrayAPIResource<Post>(requestAPIType: BasicAPIRequest.posts))
  }
  
  func getPostsUID10() -> Observable<[Post]> {
    BasicNetworkService().load(resource: ArrayAPIResource<Post>(requestAPIType: BasicAPIRequest.postsUID10))
  }
}

