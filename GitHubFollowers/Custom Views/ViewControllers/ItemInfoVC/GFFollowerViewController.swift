//
//  GFFollowerViewController.swift
//  GitHubFollowers
//
//  Created by Dmytro Akulinin on 07.04.2023.
//

import UIKit

protocol GFFollowerVCDelegate: UserInfoViewController {
  func didTapGetFollowers(for user: User)
}

class GFFollowerViewController: GFItemInfoViewController {
  
  weak var delegate: GFFollowerVCDelegate?
  
  init(user: User, delegate: GFFollowerVCDelegate) {
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
    itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
    itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
    actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
  }
  
  override func actionButtonTapped() {
    delegate?.didTapGetFollowers(for: user)
  }
}
