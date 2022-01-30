//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 1/30/22.
//

import UIKit

class UserInfoVC: UIViewController {
	var username: String!
	var user: User?
	override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
		title = username
		getUser(username: username)
    }

	// dismiss is a reserved word!
    @objc func dismissVC() {
        dismiss(animated: true)
    }
	
	func getUser(username: String) {
		showLoadingView()
		NetworkManager.shared.getUserInfo(for: username, completed: { [weak self] result in
			guard let self = self else { return }
			self.dismissLoadingView()

			switch result {
			case let .success(user):
				self.user = user
			case let .failure(error):
				self.presentGFAlertOnMainThread(alertTitle: "Error", message: error.rawValue, buttonTitle: "OK")
			}
		})
	}
}
