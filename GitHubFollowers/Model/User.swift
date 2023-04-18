//
//  User.swift
//  GitHubFollowers
//
//  Created by Dmytro Akulinin on 21.03.2023.
//

import Foundation

struct User: Codable {
  let login: String
  let avatarUrl: URL
  var name: String?
  var location: String?
  var bio: String?
  let publicRepos: Int
  let publicGists: Int
  let htmlUrl: URL
  let followers: Int
  let following: Int
  let createdAt: Date

//  private enum CodingKeys: String, CodingKey {
//    case login
//    case avatarURL = "avatar_url"
//    case name
////    case company
//    case location
////    case email
//    case bio
//    case publicRepos = "public_repos"
//    case publicGists = "public_gists"
//    case htmlUrl = "html_url"
//    case followers
//    case following
//    case createdAt = "created_at"
//  }
}
