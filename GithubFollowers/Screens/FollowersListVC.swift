//
//  FollowersListVC.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 1/22/22.
//

import UIKit

class FollowersListVC: UIViewController {
    var username: String!
    // other function will have to access collectionView, so we're declaring as a property
    var collectionView: UICollectionView!

    // tip - have viewDidLoad read like a list of functions, refactor all logic out when possible
    // it's like a table of contents for a book
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers()
    }

    // addressing the bug between hiding/showing navbar between two different VCs (swiping back)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    func configureViewController() {
        view.backgroundColor = .systemBackground
        // have to reset back to false due to config in SearchVC
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func configureCollectionView() {
        // initialize before adding as subview, as you can't add a nil as a subview
        // view.bounds = fill up whole view
        // collectionViewLayOut: UICollectionViewLayout() is default for now, will customize later
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        // pink for debugging
        collectionView.backgroundColor = .systemPink
        collectionView.register(GFFollowerCell.self, forCellWithReuseIdentifier: GFFollowerCell.reuseID)
    }

	// this is going to be refactored out
    func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
        // full width of screen
        let width = view.bounds.width
        // UI edge insets
        let padding: CGFloat = 12
        // spacing between cells
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3

        let flowLayout = UICollectionViewFlowLayout()
        // could refactor to use extension
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        // make height dynamic + some space for the usernameLabel
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)

        return flowLayout
    }

    func getFollowers() {
        // refactored to use result, no need to use unwrap optionals
        NetworkManager.shared.getFollowers(for: username, page: 1, completed: { result in

            switch result {
            case let .success(followers):
                print("Number of followers:", followers.count)

            case let .failure(error):
                self.presentGFAlertOnMainThread(alertTitle: "Error", message: error.rawValue, buttonTitle: "OK")
            }
        })
    }
}
