//
//  GFTabBarController.swift
//  GitHubFollowers
//
//  Created by Dmytro Akulinin on 18.04.2023.
//

import UIKit

class GFTabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    UITabBar.appearance().tintColor = .systemGreen
    
    viewControllers = [createSearchNavigationController(), createFavoritesNavigationController()]
    
    // Old style tab bar appearance
    if #available(iOS 13.0, *) {
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        tabBarAppearance.backgroundColor = .systemGray6
        UITabBar.appearance().standardAppearance = tabBarAppearance

        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
    
  }
  
  func createSearchNavigationController() -> UINavigationController {
    let searchVC = SearchViewController()
    searchVC.title = "Search"
    searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
    
    return UINavigationController(rootViewController: searchVC)
  }
  
  func createFavoritesNavigationController() -> UINavigationController {
    let favoritesVC = FavoriteListViewController()
    favoritesVC.title = "Favorite"
    favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
    
    return UINavigationController(rootViewController: favoritesVC)
  }
  
}
