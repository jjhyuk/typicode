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
  // test
  case postsUID10
  
  var method: HTTPMethod {
      return .get
  }
  
  var path: String {
    switch self {
    case .albums:
      return "/albums"
    case .posts:
      return "/posts"
    // test
    case .postsUID10:
      return "/posts?userId=10"
    }
  }
  
  var encoding: ParameterEncoding {
    return URLEncoding.default
  }
  
  func asURLRequest() throws -> URLRequest {
    
    print(baseURL.appending(path))
    print(method.rawValue)
    
    let originalRequest = try URLRequest(url: baseURL.appending(path),
                                         method: method,
                                         headers: headers)
    let encodedRequest = try encoding.encode(originalRequest,
                                             with: parameters)
    
    return encodedRequest
  }
  
  
}
