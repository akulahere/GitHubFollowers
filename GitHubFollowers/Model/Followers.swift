//
//  Followers.swift
//  GitHubFollowers
//
//  Created by Dmytro Akulinin on 21.03.2023.
//

import Foundation

struct Followers: Codable {
  let login: String
  let id: Int
  let nodeID: String
  let avatarURL: URL
  let gravatarID: String
  let url: URL
  let htmlURL: URL
  let followersURL: URL
  let followingURL: String
  let gistsURL: String
  let starredURL: String
  let subscriptionsURL: URL
  let organizationsURL: URL
  let reposURL: URL
  let eventsURL: String
  let receivedEventsURL: URL
  let type: String
  let siteAdmin: Bool

  private enum CodingKeys: String, CodingKey {
    case login
    case id
    case nodeID = "node_id"
    case avatarURL = "avatar_url"
    case gravatarID = "gravatar_id"
    case url
    case htmlURL = "html_url"
    case followersURL = "followers_url"
    case followingURL = "following_url"
    case gistsURL = "gists_url"
    case starredURL = "starred_url"
    case subscriptionsURL = "subscriptions_url"
    case organizationsURL = "organizations_url"
    case reposURL = "repos_url"
    case eventsURL = "events_url"
    case receivedEventsURL = "received_events_url"
    case type
    case siteAdmin = "site_admin"
  }
}
