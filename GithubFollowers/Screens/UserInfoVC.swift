//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 1/30/22.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

class UserInfoVC: GFDataLoadingVC {
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    var itemViews = [UIView]()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    let scrollView = UIScrollView()
    let contentView = UIView()

    var username: String!

    weak var delegate: UserInfoVCDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureScrollView()
        layoutUI()
        getUserInfo()
    }

    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }

    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        // content view needs total of six constraints for scrolling, so add height and width
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 610),
        ])
    }

    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username, completed: { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()

            switch result {
            case let .success(user):
                DispatchQueue.main.async { self.configureUIElements(with: user) }
            case let .failure(error):
                self.presentGFAlertOnMainThread(alertTitle: "Error", message: error.rawValue, buttonTitle: "OK")
            }
        })
    }

    func configureUIElements(with user: User) {
        let repoItemVC = GFRepoItemVC(user: user)
        repoItemVC.delegate = self

        let followerItemVC = GFFollowerItemVC(user: user)
        followerItemVC.delegate = self

        add(childVC: repoItemVC, to: itemViewOne)
        add(childVC: followerItemVC, to: itemViewTwo)
        add(childVC: GFUserInfoHeader(user: user), to: headerView)
        // .DateDecodingStrategy gives date, so only need to convert to mm YYYY
        dateLabel.text = "Github since \(user.createdAt.convertToMonthYearFormat())"
    }

    func layoutUI() {
        let itemHeight: CGFloat = 140
        let padding: CGFloat = 20

        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]

        for itemView in itemViews {
            // now add to contentView for scrolling
            contentView.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            ])
        }

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),

            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),

            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),

            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    func add(childVC: UIViewController, to containerView: UIView) {
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

extension UserInfoVC: GFRepoItemVCDelegate {
    func didTapGithubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(alertTitle: "Invalid URL", message: "The url associated with this user is invalid", buttonTitle: "OK")
            return
        }
        presentSafariVC(with: url)
    }
}

extension UserInfoVC: GFFollowerItemVCDelegate {
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(alertTitle: "No followers", message: "This user has no followers", buttonTitle: "OK")
            return
        }
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
}
