//
//  UserInfoViewController.swift
//  GitHubFollowers
//
//  Created by Dmytro Akulinin on 03.04.2023.
//

import UIKit

protocol UserInfoViewControllerDelegate: FollowerListViewController {
  func didRequestFollowers(for username: String)
}

class UserInfoViewController: GFDataLoadingVC {
  private let headerView = UIView()
  private let itemViewOne = UIView()
  private let itemViewTwo = UIView()
  private let dateLabel = GFBodyLabel(textAlignment: .center)
  private var itemViews: [UIView] = []
  
  weak var delegate: UserInfoViewControllerDelegate?
  
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
    configureViewController()
    layoutUI()
    getUserInfo()
  }
  
  private func configureViewController() {
    view.backgroundColor = .systemBackground
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
    navigationItem.rightBarButtonItem = doneButton
  }
  
  private func getUserInfo() {
    NetworkManager.shared.getUserInfo(for: username) {[weak self] result in
      guard let self = self else { return }
      switch result {
        case .success(let user):
          print(user)
          DispatchQueue.main.async {
            self.configureUIElement(with: user)
          }
        case .failure(let error):
          self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
      }
    }
  }
  
  func configureUIElement(with user: User) {
    let followerItemVC = GFFollowerViewController(user: user, delegate: self)
    let repoItemVC = GFRepoItemViewController(user: user, delegate: self)

    self.add(childVC: followerItemVC, to: self.itemViewOne)
    self.add(childVC: repoItemVC, to: self.itemViewTwo)
    self.add(childVC: GFUserInfoHeaderViewController(user: user), to: self.headerView)
    print()
    self.dateLabel.text = "GitHub Since \(user.createdAt.convertToMonthYearFormat())"
  }
  private func layoutUI() {
    let padding: CGFloat = 20
    let itemHeight: CGFloat = 140
    
    itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
    for itemView in itemViews {
      view.addSubview(itemView)
      itemView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
        itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      ])
      
    }
    
    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      headerView.heightAnchor.constraint(equalToConstant: 180),
      
      itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
      itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
      
      itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
      itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
      
      dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
      dateLabel.heightAnchor.constraint(equalToConstant: 18)
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

extension UserInfoViewController: GFFollowerVCDelegate, GFRepoItemVCDelegate {
  func didTapGitHubProfile(for user: User) {
    let url = user.htmlUrl
    presentSafariVC(with: url)

  }
  
  func didTapGetFollowers(for user: User) {
    guard user.followers != 0 else {
      presentGFAlertOnMainThread(title: "No followers", message: "This use has no followers", buttonTitle: "So ad")
      return
    }
    delegate?.didRequestFollowers(for: user.login)
    dismissVC()
  }
  

}
