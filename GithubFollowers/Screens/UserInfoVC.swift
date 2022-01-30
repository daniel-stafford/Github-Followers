//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 1/30/22.
//

import UIKit

class UserInfoVC: UIViewController {
	var username: String!
	
	override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
		title = username
    }

	// dismiss is a reserved word!
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}
