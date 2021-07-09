//
//  BasicAPIRequest.swift
//  typicode
//
//  Created by jinhyuk on 2021/07/09.
//

import Alamofire

enum BasicAPIRequest: APIRequestConvertible {
  
  case posts
  case albums
  
  var method: HTTPMethod {
      return .get
  }
  
  var path: String {
    switch self {
    case .albums:
      return "/albums"
    case .posts:
      return "/posts"
    }
  }
  
  var encoding: ParameterEncoding {
    return URLEncoding.default
  }
  
  func asURLRequest() throws -> URLRequest {
    
    let originalRequest = try URLRequest(url: baseURL.appending(path),
                                         method: method,
                                         headers: headers)
    let encodedRequest = try encoding.encode(originalRequest,
                                             with: parameters)
    
    return encodedRequest
  }
  
  
}
