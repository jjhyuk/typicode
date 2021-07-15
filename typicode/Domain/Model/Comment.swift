//
//  Comment.swift
//  typicode
//
//  Created by jinhyuk on 2021/07/15.
//

import Foundation

struct Comment: Codable {
  let postId: Int
  let id: Int
  let name: String
  let email: String
  let body: String
}
