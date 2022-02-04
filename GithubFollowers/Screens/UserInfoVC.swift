//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 1/30/22.
//

import UIKit

class UserInfoVC: UIViewController {
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    var itemViews = [UIView]()

    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        getUserInfo()
    }

    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }

    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username, completed: { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()

            switch result {
            case let .success(user):
                DispatchQueue.main.async { self.addChildVC(childVC: GFUserInfoHeader(user: user), to: self.headerView) }
            case let .failure(error):
                self.presentGFAlertOnMainThread(alertTitle: "Error", message: error.rawValue, buttonTitle: "OK")
            }
        })
    }

    func layoutUI() {
        let itemHeight: CGFloat = 140
        let padding: CGFloat = 20

        itemViews = [headerView, itemViewOne, itemViewTwo]

        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            ])
        }

        itemViewOne.backgroundColor = .systemPink
        itemViewTwo.backgroundColor = .systemRed

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),

            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),

            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
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
}
