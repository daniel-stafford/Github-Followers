//
//  FollowersListVC.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 1/22/22.
//

import UIKit

class FollowersListVC: UIViewController {
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // have to reset back to false due to config in SearchVC
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        NetworkManager.shared.getFollowers(for: username, page: 1, completed: { [weak self] followers, error in
            guard let followers = followers else {
                self?.presentGFAlertOnMainThread(alertTitle: "Error", message: error ?? "Something went wrong", buttonTitle: "OK")
                return
            }
            print("Number of followers:", followers.count)
        })
    }

    // addressing the bug between hiding/showing navbar between two different VCs (swiping back)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
