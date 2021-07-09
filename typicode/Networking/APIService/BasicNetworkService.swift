//
//  BasicNetworkService.swift
//  typicode
//
//  Created by jinhyuk on 2021/07/09.
//

import Foundation
import RxSwift
import RxAlamofire

struct BasicNetworkService: NetworkService {
  
  func load<T>(resource: ArrayAPIResource<T>) -> Observable<[T]> where T : Decodable, T : Encodable {
    return RxAlamofire
      .request(resource.requestAPIType)
      .debug()
      .responseJSON()
      .debug()
      .map { $0.data ?? Data() }
      .flatMap(resource.parse)
  }
}
