//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Dmytro Akulinin on 21.03.2023.
//

import UIKit

class NetworkManager {
  static let shared = NetworkManager()
  let baseUrl = "http://api.github.com/users/"
  let cache = NSCache<NSString, UIImage>()
  
  private init() {}
  
  func getFollowers(
    for username: String,
    page: Int,
    completed: @escaping(Result<[Follower], GFError>) -> Void
  ) {
    let endpoint = baseUrl + username + "/followers?per_page=10&page=\(page)"
    
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
        decoder.dateDecodingStrategy = .iso8601

        let followers = try decoder.decode([Follower].self, from: data)
        completed(.success(followers))
      } catch {
        completed(.failure(.invalidData))
      }
    }
    
    task.resume()
  }
  
  func getUserInfo(for username: String, completed: @escaping (Result<User, GFError>) -> Void) {
    let endpoint = baseUrl + "\(username)"
    
    guard let url = URL(string: endpoint) else {
      completed(.failure(.invalidUsername))
      return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if error != nil {
        completed(.failure(.unableToComplete))
      }
      
      guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        completed(.failure(.unableToComplete))
        return
      }
      
      guard let data else {
        completed(.failure(.invalidData))
        return
      }
      
      do {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let user = try decoder.decode(User.self, from: data)

        completed(.success(user))
      } catch {
        completed(.failure(.invalidData))
      }
    }
    
    task.resume()
  }
  
  func downloadImage(from url: URL, completed: @escaping (UIImage?) -> Void) {
    let cacheKey = NSString(string: url.absoluteString)
    if let image = cache.object(forKey: cacheKey) {
      completed(image)
      return
    }
    
    let task = URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
      
      guard
        error == nil,
        let response = response as? HTTPURLResponse,
        response.statusCode == 200,
        let data = data,
        let image = UIImage(data: data) else {
          completed(nil)
        return
        }
      
      self?.cache.setObject(image, forKey: cacheKey)
      completed(image)
    }
    task.resume()
  }
  
}
