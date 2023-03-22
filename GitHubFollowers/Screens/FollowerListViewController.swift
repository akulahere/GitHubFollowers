//
//  FollowerListViewController.swift
//  GitHubFollowers
//
//  Created by Dmytro Akulinin on 20.03.2023.
//

import UIKit

class FollowerListViewController: UIViewController {
  var username: String!
  var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
    configureCollectionView()
    getFollowers()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: true)
  }
  
  func configureViewController() {
    view.backgroundColor = .systemBackground
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  func configureCollectionView() {
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
    view.addSubview(collectionView)
    collectionView.backgroundColor = .systemPink
    collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
  }
  
  func getFollowers() {
    NetworkManager.shared.getFollowers(for: username, page: 1) { result in
      switch result {
      case .success(let followers):
        print(followers)
      case .failure(let error):
        self.presentGFAlertOnMainThread(title: "Error", message: error.rawValue ?? "Something go wrong", buttonTitle: "Ok")
      }
    }
  }
}
