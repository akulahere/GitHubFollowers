//
//  User.swift
//  GitHubFollowers
//
//  Created by Dmytro Akulinin on 21.03.2023.
//

import Foundation

struct User: Codable {
  let login: String
  let avatarURL: URL
  var name: String?
//  let company: String
  var location: String?
//  let email: String
  var bio: String?
  let publicRepos: Int
  let publicGists: Int
  let htmlURL: URL
  let followers: Int
  let following: Int
  let createdAt: String

  private enum CodingKeys: String, CodingKey {
    case login
    case avatarURL = "avatar_url"
    case name
//    case company
    case location
//    case email
    case bio
    case publicRepos = "public_repos"
    case publicGists = "public_gists"
    case htmlURL = "html_url"
    case followers
    case following
    case createdAt = "created_at"
  }
}
