//
//  APIRequestConvertible.swift
//  typicode
//
//  Created by jinhyuk on 2021/07/09.
//

import Alamofire

protocol APIRequestConvertible: URLRequestConvertible {
  var method: HTTPMethod { get }
  var path: String { get }
  var parameters: [String: Any] { get }
  var baseURL: String { get }
  var headers: HTTPHeaders { get }
  var encoding: ParameterEncoding { get }
}

extension APIRequestConvertible {
  var parameters: [String : Any] {
    return [:]
  }
  var headers: HTTPHeaders {
    return HTTPHeaders([:])
  }
  var baseURL: String {
    return "https://jsonplaceholder.typicode.com"
  }
}
