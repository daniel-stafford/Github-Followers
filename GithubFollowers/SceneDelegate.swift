//
//  SceneDelegate.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 1/22/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    

    // similar to didFinishLaunchingWithOptions in appDelegate pre-iOS 13
    // import to keep this function tidy, separate out to functions when possible
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // fill up entire screen with scene
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        // assign our window's windowScene to delegate's windowScene
        window?.windowScene = windowScene
        // set up root controller
        window?.rootViewController = createTabBar()
        // make visible
        window?.makeKeyAndVisible()
        // remember to add app icons!
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

    func createTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        // change tab bar tint color system wise
        UITabBar.appearance().tintColor = .systemGreen
        tabBar.viewControllers = [createSearchNC(), createFavoritesNC()]

        return tabBar
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}
