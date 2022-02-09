//
//  FavoritesVC.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 1/22/22.
//

import UIKit

class FavoritesVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // system color adjust slightly to dark and light modes
        view.backgroundColor = .systemBrown
        PersistenceManager.retrieveFavorites { [weak self] result in
			guard let self = self else { return }
            switch result {
            case let .success(followers):
                print(followers)
            case let .failure(error):
				self.presentGFAlertOnMainThread(alertTitle: "Error", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
}
