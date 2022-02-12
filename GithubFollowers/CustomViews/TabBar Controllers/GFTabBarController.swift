//
//  GFTabBarController.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 2/12/22.
//

import UIKit

class GFTabBarController: UITabBarController {
    override func viewDidLoad() {
		super.viewDidLoad()
        // change tab bar tint color system wise
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNC(), createFavoritesNC()]
    }

    func createSearchNC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        // tag = 0, first on left
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)

        return UINavigationController(rootViewController: searchVC)
    }

    // if you have to crate a function that takes a ton of parameters , not worth doing DRY
    func createFavoritesNC() -> UINavigationController {
        let favoritesVC = FavoritesVC()
        favoritesVC.title = "Favorites"
        // tag: 1, first on right
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)

        // remember to use L (local variable) vs C class for favoritesVC
        return UINavigationController(rootViewController: favoritesVC)
    }
}
