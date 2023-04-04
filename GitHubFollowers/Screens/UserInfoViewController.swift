//
//  UserInfoViewController.swift
//  GitHubFollowers
//
//  Created by Dmytro Akulinin on 03.04.2023.
//

import UIKit

class UserInfoViewController: UIViewController {
  let headerView = UIView()
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
    layoutUI()
    
    NetworkManager.shared.getUserInfo(for: username) {[weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let user):
          print(user)
          DispatchQueue.main.async {
            self.add(childVC: GFUserInfoHeaderViewController(user: user), to: self.headerView)
          }
      case .failure(let error):
        self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
      }
    }
    layoutUI()
  }
  
  func layoutUI() {
    view.addSubview(headerView)
    headerView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      headerView.heightAnchor.constraint(equalToConstant: 180)
    
    ])
  }
  
  func add(childVC: UIViewController, to containerView: UIView) {
    addChild(childVC)
    containerView.addSubview(childVC.view)
    childVC.view.frame = containerView.bounds
    childVC.didMove(toParent: self)
  }
  @objc func dismissVC() {
    dismiss(animated: true)
  }
}