//
//  FollowerCell.swift
//  GitHubFollowers
//
//  Created by Dmytro Akulinin on 22.03.2023.
//

import UIKit

class FollowerCell: UICollectionViewCell {
  static let reuseID = "FollowerCell"
  private let padding: CGFloat = 8

  private let avatarImageView = GFAvatarImageView(frame: .zero)
  private let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
    func set(follower: Follower) {
        avatarImageView.downloadImage(fromURL: follower.avatarURL)
        usernameLabel.text = follower.login
    }
  
  private func configure() {
    addSubview(avatarImageView)
    addSubview(usernameLabel)
    NSLayoutConstraint.activate([
      avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
      avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
      avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: padding),
      avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
      
      usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
      usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
      usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: padding),
      usernameLabel.heightAnchor.constraint(equalToConstant: 20)
    ])
  }
}
