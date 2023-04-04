//
//  GFUserInfoHeaderViewController.swift
//  GitHubFollowers
//
//  Created by Dmytro Akulinin on 04.04.2023.
//

import UIKit

class GFUserInfoHeaderViewController: UIViewController {
  private let avatarImageInfo = GFAvatarImageView(frame: .zero)
  private let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 34)
  private let nameLabel = GFSecondaryTitleLabel(fontSize: 18)
  private let locationImageView = UIImageView()
  private let locationLabel = GFSecondaryTitleLabel(fontSize: 18)
  private let bioLabel = GFBodyLabel(textAlignment: .left)
  
  var user: User
  
  init(user: User) {
    self.user = user
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUIElements()
    addSubviews()
    layoutUI()
  }
  
  func configureUIElements() {
    avatarImageInfo.downloadImage(from: user.avatarURL)
    usernameLabel.text = user.login
    nameLabel.text = user.name ?? "No name"
    locationLabel.text = user.location ?? "No location"
    bioLabel.text = user.bio ?? "No bio available"
    bioLabel.numberOfLines = 3
    
    locationImageView.image = UIImage(systemName: SFSymbols.location)
    locationImageView.tintColor = .secondaryLabel
  }
  
  func addSubviews() {
    view.addSubview(avatarImageInfo)
    view.addSubview(usernameLabel)
    view.addSubview(nameLabel)
    view.addSubview(locationImageView)
    view.addSubview(locationLabel)
    view.addSubview(bioLabel)
  }
  
  func layoutUI() {
    let padding: CGFloat = 20
    let textImagePadding: CGFloat = 12
    locationImageView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      avatarImageInfo.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
      avatarImageInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      avatarImageInfo.widthAnchor.constraint(equalToConstant: 90),
      avatarImageInfo.heightAnchor.constraint(equalToConstant: 90),
      
      usernameLabel.topAnchor.constraint(equalTo: avatarImageInfo.topAnchor),
      usernameLabel.leadingAnchor.constraint(equalTo: avatarImageInfo.trailingAnchor, constant: textImagePadding),
      usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      usernameLabel.heightAnchor.constraint(equalToConstant: 38),
      
      nameLabel.centerYAnchor.constraint(equalTo: avatarImageInfo.centerYAnchor, constant: 8),
      nameLabel.leadingAnchor.constraint(equalTo: avatarImageInfo.trailingAnchor, constant: textImagePadding),
      nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      nameLabel.heightAnchor.constraint(equalToConstant: 20),
      
      locationImageView.bottomAnchor.constraint(equalTo: avatarImageInfo.bottomAnchor),
      locationImageView.leadingAnchor.constraint(equalTo: avatarImageInfo.trailingAnchor, constant: textImagePadding),
      locationImageView.widthAnchor.constraint(equalToConstant: 20),
      locationImageView.heightAnchor.constraint(equalToConstant: 20),
      
      locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
      locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
      locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      locationLabel.heightAnchor.constraint(equalToConstant: 20),
      
      bioLabel.topAnchor.constraint(equalTo: avatarImageInfo.bottomAnchor, constant: textImagePadding),
      bioLabel.leadingAnchor.constraint(equalTo: avatarImageInfo.leadingAnchor),
      bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      bioLabel.heightAnchor.constraint(equalToConstant: 60)
    ])
  }
}
