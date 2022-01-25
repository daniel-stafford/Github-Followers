//
//  SearchVC.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 1/22/22.
//

import UIKit

class SearchVC: UIViewController {
    // consider listing in order for how they appear in App
    let logoImageView = UIImageView()
    let usernameTextField = GFTextField()
    // try to keep names generic
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")

    var isUsernameEntered: Bool { !(usernameTextField.text?.isEmpty ?? false) }

    override func viewDidLoad() {
        super.viewDidLoad()
        // white for dark mode and vice versa
        view.backgroundColor = .systemBackground
        // remember to call this!
        configureLogoImageView()
        configureUserNameTextField()
        configureCallToActionButton()
        dismissKeyBoardTapeGesture()
    }

    // hide navBar in viewDidAppear as will get called on back navigation, viewDidLoad only gets called once!
    override func viewWillAppear(_ animated: Bool) {
        // remember to call the super! Unless you don't want parent functionality
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    func dismissKeyBoardTapeGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        // tap anywhere to dismiss keyboard
        view.addGestureRecognizer(tap)
    }

    @objc func pushFollowerListVC() {
        let followersListVC = FollowersListVC()
        // basic text validation, could get regex for further validation
        guard isUsernameEntered else {
            let title = "Empty Username"
            let message = "Please enter a Github username, so we know who to look for! 😀"
            let buttonTitle = "OK"
            presentGFAlertOnMainThread(alertTitle: title, message: message, buttonTitle: buttonTitle)
            return
        }
        followersListVC.username = usernameTextField.text
        followersListVC.title = usernameTextField.text
        navigationController?.pushViewController(followersListVC, animated: true)
    }

    func configureLogoImageView() {
        // whenever we tap this button, pushFollowerListVC will run
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        // same as creating an @IB Outlet, easy to forget 😊
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        // stringly typed: dangerous, so should be moved to a constant later
        logoImageView.image = UIImage.named("gh-logo")
        // typically four constraints
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            // tip: when creating own assets use square images, much easier to layout!
            // 200 x 200 is useful as iPhone SE is 320 points, see https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
        ])
    }

    func configureUserNameTextField() {
        view.addSubview(usernameTextField)
        // 👀 set the searchVC to listen for usernameTextField, easy to forget this!
        usernameTextField.delegate = self

        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            // no need not to safeAreaLayoutGuide for left and right
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            // remember to use negative for trailing side!
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            // HIG: at least 44 points
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    // better to be specific and not just use configureButton
    func configureCallToActionButton() {
        view.addSubview(callToActionButton)

        NSLayoutConstraint.activate([
            // remember negative for bottom anchor!
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

// cleaner to set delegates as separate extension
extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}
