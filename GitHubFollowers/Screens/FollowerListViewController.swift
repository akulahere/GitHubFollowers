//
//  FollowerListViewController.swift
//  GitHubFollowers
//
//  Created by Dmytro Akulinin on 20.03.2023.
//

import UIKit

class FollowerListViewController: UIViewController {
  var username: String!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    navigationController?.navigationBar.prefersLargeTitles = true
    NetworkManager.shared.getFollowers(for: username, page: 1) { followers, errorMessage in
      guard let followers else {
        self.presentGFAlertOnMainThread(title: "Error", message: errorMessage?.rawValue ?? "Something go wrong", buttonTitle: "Ok")
        return
      }
      
      print(followers)
        
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: true)
  }
}
