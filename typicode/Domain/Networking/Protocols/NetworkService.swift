//
//  NetworkService.swift
//  typicode
//
//  Created by jinhyuk on 2021/07/09.
//

import Foundation
import RxSwift
import RxAlamofire

protocol NetworkService {
  func load<T>(resource:ArrayAPIResource<T>) -> Observable<[T]>
}
