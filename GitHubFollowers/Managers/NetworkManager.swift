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
    completed: @escaping(Result<[Follower], GFError>) -> Void
  ) {
    let endpoint = baseUrl + username + "/followers?per_page=100&page=\(page)"
    
    guard let url = URL(string: endpoint) else {
      completed(.failure(.invalidUsername))
      return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if error != nil {
        completed(.failure(.unableToComplete))
        print(error.debugDescription)
      }
      
      guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        completed(.failure(.unableToComplete))
        print("response")
        return
      }
      
      guard let data else {
        completed(.failure(.invalidData))
        return
      }
      
      do {
        let decoder = JSONDecoder()
        let followers = try decoder.decode([Follower].self, from: data)
        completed(.success(followers))
      } catch {
        completed(.failure(.invalidData))
      }
    }
    
    task.resume()
  }
}
