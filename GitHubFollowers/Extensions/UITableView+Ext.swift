//
//  UITableView+Ext.swift
//  GitHubFollowers
//
//  Created by Dmytro Akulinin on 19.04.2023.
//

import UIKit

extension UITableView {
  func reloadDataOnMainThread() {
    DispatchQueue.main.async {
      self.reloadData()
    }
  }
}
