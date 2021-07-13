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
  
  func load<T>(resource: ArrayAPIResource<T>) -> Observable<[T]> {
    return RxAlamofire
      .request(resource.requestAPIType)
      .responseString()
      .flatMap { (response, string) -> Observable<[T]> in
        if 200...300 ~= response.statusCode {
          return resource.parse(string.data(using: .utf8) ?? Data())
        }
        
        return Observable.error(APIError.init(value: "error"))
      }
//    return RxAlamofire
//      .request(resource.requestAPIType)
//      .responseJSON()
//      .map { $0.data ?? Data() }
//      .flatMap(resource.parse)
  }
}
