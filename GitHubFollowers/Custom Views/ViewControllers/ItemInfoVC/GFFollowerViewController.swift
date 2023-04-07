//
//  GFFollowerViewController.swift
//  GitHubFollowers
//
//  Created by Dmytro Akulinin on 07.04.2023.
//

import UIKit

class GFFollowerViewController: GFRepoItemViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    configureItems()
  }
  
  private func configureItems() {
    itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
    itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
    actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
  }
}
