//
//  Post.swift
//  typicode
//
//  Created by jinhyuk on 2021/07/09.
//

import Foundation

struct Post: Codable {
  let userId: Int
  let id: Int
  let title: String
  let body: String
}
