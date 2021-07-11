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
  
  // test
  var change: Bool = false
  func testTab() {
    
    if change {
      change.toggle()
      BasicNetworkService().load(resource: ArrayAPIResource<Post>(requestAPIType: BasicAPIRequest.postsUID10))
        .subscribe(fetchDataSubject)
        .disposed(by: disposBag)
    }
    else {
      change.toggle()
      BasicNetworkService().load(resource: ArrayAPIResource<Post>(requestAPIType: BasicAPIRequest.posts))
        .subscribe(fetchDataSubject)
        .disposed(by: disposBag)
    }
    
  }
  
  var fetchDataSubject: PublishSubject<[Post]> = PublishSubject<[Post]>()
  
  let disposBag: DisposeBag = DisposeBag()
  
  init() {
    // DI
    BasicNetworkService().load(resource: ArrayAPIResource<Post>(requestAPIType: BasicAPIRequest.posts))
      .subscribe(fetchDataSubject)
      .disposed(by: disposBag)
  }
  
  
  
}
