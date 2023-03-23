//
//  Followers.swift
//  GitHubFollowers
//
//  Created by Dmytro Akulinin on 21.03.2023.
//

import Foundation

struct Follower: Codable, Hashable {
  let login: String
  let avatarURL: URL

  private enum CodingKeys: String, CodingKey {
    case login
    case avatarURL = "avatar_url"
  }
}
