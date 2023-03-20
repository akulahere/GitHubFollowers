//
//  SearchViewController.swift
//  GitHubFollowers
//
//  Created by Dmytro Akulinin on 16.03.2023.
//

import UIKit

class SearchViewController: UIViewController {
  
  private let logoImageView = UIImageView()
  private let usernameTextField = GFTextField()
  private let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
  private var isUserNameEntered: Bool {
    return !usernameTextField.text!.isEmpty
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    configureLogoImageView()
    configureTextField()
    configureCallToActionButton()
    createDismissKeyboardTapGesture()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.isNavigationBarHidden = true
  }
  
  private func createDismissKeyboardTapGesture() {
    let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
    view.addGestureRecognizer(tap)
  }
  
  @objc private func pushFollowerListViewController() {
    guard isUserNameEntered else {
      print("No userName")
      return
    }
    let followerListVC = FollowerListViewController()
    followerListVC.username = usernameTextField.text
    followerListVC.title = usernameTextField.text
    navigationController?.pushViewController(followerListVC, animated: true)
  }
  
  private func configureLogoImageView() {
    view.addSubview(logoImageView)
    logoImageView.translatesAutoresizingMaskIntoConstraints = false
    logoImageView.image = UIImage(named: "gh-logo")
    
    NSLayoutConstraint.activate([
      logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
      logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      logoImageView.heightAnchor.constraint(equalToConstant: 200),
      logoImageView.widthAnchor.constraint(equalToConstant: 200),
    ])
  }
  
  private func configureTextField() {
    view.addSubview(usernameTextField)
    usernameTextField.delegate = self
    NSLayoutConstraint.activate([
      usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
      usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
      usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
      usernameTextField.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
  private func configureCallToActionButton() {
    view.addSubview(callToActionButton)
    callToActionButton.addTarget(self, action: #selector(pushFollowerListViewController), for: .touchUpInside)

    NSLayoutConstraint.activate([
      callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
      callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
      callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
      callToActionButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
}

extension SearchViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    pushFollowerListViewController()
    return true
  }
}
