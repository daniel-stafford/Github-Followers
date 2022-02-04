//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 1/30/22.
//

import UIKit

class UserInfoVC: UIViewController {
    let headerView = UIView()

    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        layoutUI()

        NetworkManager.shared.getUserInfo(for: username, completed: { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()

            switch result {
            case let .success(user):
                DispatchQueue.main.async { self.addChildVC(childVC: GFUserInfoHeader(user: user), to: self.headerView) }
            case let .failure(error):
                DispatchQueue.main.async { self.presentGFAlertOnMainThread(alertTitle: "Error", message: error.rawValue, buttonTitle: "OK") }
            }
        })
    }

    func layoutUI() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
        ])
    }

    func addChildVC(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        // fill up entire container view
        childVC.view.frame = containerView.bounds
        // assign childVC to self (UserInfoVC)
        childVC.didMove(toParent: self)
    }

    // dismiss is a reserved word!
    @objc func dismissVC() {
        dismiss(animated: true)
    }

    func getUser(username: String) {
        showLoadingView()
    }
}
