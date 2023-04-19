//
//  GFRepoItemViewController.swift
//  GitHubFollowers
//
//  Created by Dmytro Akulinin on 07.04.2023.
//

import UIKit

protocol GFRepoItemVCDelegate: UserInfoViewController {
  func didTapGitHubProfile(for user: User)
}

class GFRepoItemViewController: GFItemInfoViewController {
  weak var delegate: GFRepoItemVCDelegate?
  
  init(user: User, delegate: GFRepoItemVCDelegate) {
    super.init(user: user)
    self.delegate = delegate
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureItems()
  }
  
  private func configureItems() {
    itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
    itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
    actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
  }
  
  override func actionButtonTapped() {
    delegate?.didTapGitHubProfile(for: user)
  }
}
