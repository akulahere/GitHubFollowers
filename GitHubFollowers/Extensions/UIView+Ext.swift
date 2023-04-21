//
//  UIView+Ext.swift
//  GitHubFollowers
//
//  Created by Dmytro Akulinin on 20.04.2023.
//

import UIKit

extension UIView {
  func pinToEdges(of superview: UIView) {
    translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      topAnchor.constraint(equalTo: superview.topAnchor),
      leadingAnchor.constraint(equalTo: superview.leadingAnchor),
      trailingAnchor.constraint(equalTo: superview.trailingAnchor),
      bottomAnchor.constraint(equalTo: superview.bottomAnchor)
    ])
  }
}
