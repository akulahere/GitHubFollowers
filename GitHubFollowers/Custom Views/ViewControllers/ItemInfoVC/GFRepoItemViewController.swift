//
//  GFRepoItemViewController.swift
//  GitHubFollowers
//
//  Created by Dmytro Akulinin on 07.04.2023.
//

import UIKit

class GFRepoItemViewController: GFItemInfoViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    configureItems()
  }
  
  private func configureItems() {
    itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
    itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
    actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
  }
}
