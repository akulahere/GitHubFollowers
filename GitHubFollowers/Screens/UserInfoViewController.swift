//
//  UserInfoViewController.swift
//  GitHubFollowers
//
//  Created by Dmytro Akulinin on 03.04.2023.
//

import UIKit

class UserInfoViewController: UIViewController {
  var username: String
  
  init(username: String) {
    self.username = username
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
    navigationItem.rightBarButtonItem = doneButton
    
    NetworkManager.shared.getUserInfo(for: username) {[weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let user):
        print(user)
      case .failure(let error):
        self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
      }
    }
  }
  
  @objc func dismissVC() {
    dismiss(animated: true)
  }
}
