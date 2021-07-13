//
//  ArrayAPIModele.swift
//  typicode
//
//  Created by jinhyuk on 2021/07/09.
//

import Foundation
import RxSwift

struct ArrayAPIResource<T:Codable> {
  let objectType = T.self
  let requestAPIType: APIRequestConvertible
  
  func parse(_ data:Data) -> Observable<[T]> {
    Observable.create { observer in
      guard let result = try? JSONDecoder().decode([T].self, from: data) else {
        observer.onError(APIError(value: "Parsing Error"))
        return Disposables.create()
      }
      observer.onNext(result)
      return Disposables.create()
    }
  }
}
