//
//  GFDataLoadingVC.swift
//  GitHubFollowers
//
//  Created by Dmytro Akulinin on 18.04.2023.
//

import UIKit

class GFDataLoadingVC: UIViewController {
  var containerView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  func showLoadingView() {
    
    containerView = UIView(frame: view.bounds)
    view.addSubview(containerView)
    
    containerView.backgroundColor = .systemBackground
    containerView.alpha = 0
    
    UIView.animate(withDuration: 0.25) {
      self.containerView.alpha = 0.8
    }
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    containerView.addSubview(activityIndicator)
    
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
    DispatchQueue.main.async {
      activityIndicator.startAnimating()
    }
  }
  
  func dismissLoadingView() {
    DispatchQueue.main.async {
      self.containerView.removeFromSuperview()
      self.containerView = nil
    }
  }
}
