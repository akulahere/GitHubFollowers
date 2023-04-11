//
//  FavoriteListViewController.swift
//  GitHubFollowers
//
//  Created by Dmytro Akulinin on 16.03.2023.
//

import UIKit

class FavoriteListViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBlue
    
    PersistenceManager.retrieveFavourites { result in
      switch result {
        case .success(let favorites):
          print(favorites)
        case .failure(let error):
          break
      }
    }
  }
}
