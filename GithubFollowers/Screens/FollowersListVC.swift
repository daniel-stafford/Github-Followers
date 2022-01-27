//
//  FollowersListVC.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 1/22/22.
//

import UIKit

class FollowersListVC: UIViewController {
    // enums are hashable by default
    // we have only one section
    enum Section { case main }

    var username: String!
    var followers = [Follower]()

    // other functions will have to access collectionView, so we're declaring as a property
    var collectionView: UICollectionView!
    // generic parameters need to conform to hashable, must know about our section(s) and items
    // diffable data is useful for dynamic content (e.g. wifi networks, searching through a list)
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!

    // tip - have viewDidLoad read like a list of functions, refactor all logic out when possible
    // it's like a table of contents for a book
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers()
        configureDataSource()
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
        // TODO: Figure out why layout isn't working with iOS 15
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        // pink for debugging
        collectionView.register(GFFollowerCell.self, forCellWithReuseIdentifier: GFFollowerCell.reuseID)
        // default view was black
        collectionView.backgroundColor = .systemBackground
    }

    func getFollowers() {
        // refactored to use result, no need to use unwrap optionals
        // Memory leak risk, so use capture risk
        // unowned force unwraps the self, little more dangerous than weak, used less
        NetworkManager.shared.getFollowers(for: username, page: 1, completed: { [weak self] result in
            // unwrapping the optional of self, so no need for question marks, Swift 4.2
            guard let self = self else { return }

            switch result {
            case let .success(followers):
                self.followers = followers
                self.updateData()
            case let .failure(error):
                self.presentGFAlertOnMainThread(alertTitle: "Error", message: error.rawValue, buttonTitle: "OK")
            }
        })
    }

    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            // similar to storyboard flow of cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GFFollowerCell.reuseID, for: indexPath) as? GFFollowerCell
            cell?.set(follower: follower)

            return cell
        })
    }

    // where snapshots take [;ace
    func updateData() {
        // snapshot goes through hash function to get unique value, diffable then tracks it
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        // converge to section
        snapshot.appendSections([.main])
        // convert item to section
        snapshot.appendItems(followers, toSection: .main)
        // the magic function to cause
        // call on main thread just in case
        // though WWDC says OK to call on background
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
}
