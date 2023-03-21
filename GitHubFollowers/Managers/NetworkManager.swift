//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Dmytro Akulinin on 21.03.2023.
//

import Foundation

class NetworkManager {
  static let shared = NetworkManager()
  let baseUrl = "http://api.github.com/users/"
  private init() {}
  
  func getFollowers(
    for username: String,
    page: Int,
    completed: @escaping([Follower]?, ErrorMessage?) -> Void
  ) {
    let endpoint = baseUrl + username + "/followers?per_page=100&page=\(page)"
    
    guard let url = URL(string: endpoint) else {
      completed(nil, ErrorMessage.invalidUsername)
      return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if error != nil {
        completed(nil, ErrorMessage.unableToComplete)
      }
      
      guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        completed(nil, ErrorMessage.invalidResponse)
        return
      }
      
      guard let data else {
        completed(nil, ErrorMessage.invalidData)
        return
      }
      
      do {
        let decoder = JSONDecoder()
        let followers = try decoder.decode([Follower].self, from: data)
        completed(followers, nil)
      } catch {
        completed(nil, ErrorMessage.invalidData)
      }
    }
    
    task.resume()
  }
}
