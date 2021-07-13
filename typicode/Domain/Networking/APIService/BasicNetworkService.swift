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
    print("Request ==========>")
    print("HTTP Method: \(resource.requestAPIType.method.rawValue)")
    print("URL: \(resource.requestAPIType.baseURL.appending(resource.requestAPIType.path))")
    print("Header: \(resource.requestAPIType.headers.description)")
    print("Parameters: \(resource.requestAPIType.parameters.description)")
    print("====================")
    
    return RxAlamofire
      .request(resource.requestAPIType)
      .responseString()
      .flatMap { (response, string) -> Observable<[T]> in
        if 200...300 ~= response.statusCode {
          guard let data = string.data(using: .utf8) else {
            return Observable.error(APIError.init(value: "error"))
          }
          
          print("Response <==========")
          print(string.description)
          print("====================")
          return resource.parse(data)
        }
        
        return Observable.error(APIError.init(value: "error"))
      }
  }
}
