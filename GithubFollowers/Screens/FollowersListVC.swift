//
//  FollowersListVC.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 1/22/22.
//

import UIKit

class FollowersListVC: GFDataLoadingVC {
    // enums are hashable by default
    // we have only one section
    enum Section { case main }

    var username: String!
    var followers = [Follower]()
    var filteredFollowers = [Follower]()

    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    var isLoadingMoreFollowers = false

    // other functions will have to access collectionView, so we're declaring as a property
    var collectionView: UICollectionView!
    // generic parameters need to conform to hashable, must know about our section(s) and items
    // diffable data is useful for dynamic content (e.g. wifi networks, searching through a list)
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!

    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title = username
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // tip - have viewDidLoad read like a list of functions, refactor all logic out when possible
    // it's like a table of contents for a book
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        configureSearchController()
        getFollowers(username: username, page: page)
        configureDataSource()
    }

    // addressing the bug between hiding/showing navbar between two different VCs (swiping back)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        // show searchBar upon appearing
//        navigationItem.hidesSearchBarWhenScrolling = false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // hide when scrolling
        navigationItem.hidesSearchBarWhenScrolling = true
    }

    func configureViewController() {
        view.backgroundColor = .systemBackground
        // have to reset back to false due to config in SearchVC
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }

    func configureCollectionView() {
        // initialize before adding as subview, as you can't add a nil as a subview
        // view.bounds = fill up whole view
        // collectionViewLayOut: UICollectionViewLayout() is default for now, will customize later
        // TODO: Figure out why layout isn't working with iOS 15
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        // register the delegate, tell it to listen to the collectionView
        collectionView.delegate = self
        // pink for debugging
        collectionView.register(GFFollowerCell.self, forCellWithReuseIdentifier: GFFollowerCell.reuseID)
        // default view was black
        collectionView.backgroundColor = .systemBackground
    }

    func configureSearchController() {
        let searchController = UISearchController()
        // set search delegate to self
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a username"
        // show search without having to scroll down
        // prevent faint overlay
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }

    func getFollowers(username: String, page: Int) {
        // refactored to use result, no need to use unwrap optionals
        // Memory leak risk, so use capture risk
        // unowned force unwraps the self, little more dangerous than weak, used less
        showLoadingView()
        isLoadingMoreFollowers = true
        NetworkManager.shared.getFollowers(for: username, page: page, completed: { [weak self] result in
            // unwrapping the optional of self, so no need for question marks, Swift 4.2
            guard let self = self else { return }
            self.dismissLoadingView()

            switch result {
            case let .success(followers):
                if followers.count < Constants.maxFollowersPerPage { self.hasMoreFollowers.toggle() }
                //  alternative to self.followers += followers
                self.followers.append(contentsOf: followers)
                if followers.isEmpty {
                    let message = "This user doesn't have any Github followers. Go follow them! ????"

                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: message, in: self.view)
                    }
                    return
                }
                self.updateData(on: self.followers)
            case let .failure(error):
                self.presentGFAlertOnMainThread(alertTitle: "Error", message: error.rawValue, buttonTitle: "OK")
            }
            self.isLoadingMoreFollowers = false
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
    func updateData(on followers: [Follower]) {
        // snapshot goes through hash function to get unique value, diffable then tracks it
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        // converge to section
        snapshot.appendSections([.main])
        // convert item to section
        snapshot.appendItems(followers, toSection: .main)
        // the apply function to start the diff
        // call on main thread just in case
        // though WWDC says OK to call on background
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }

    @objc func addButtonTapped() {
        showLoadingView()
        NetworkManager.shared.getUserInfo(for: username, completed: { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case let .success(user):
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                    guard let self = self else { return }
                    guard let error = error else {
                        self.presentGFAlertOnMainThread(alertTitle: "Success", message: "Added \(self.username ?? "this user") to favorites.", buttonTitle: "OK")
                        return
                    }
                    self.presentGFAlertOnMainThread(alertTitle: "Error", message: error.rawValue, buttonTitle: "OK")
                }

            case let .failure(error):
                self.presentGFAlertOnMainThread(alertTitle: "Error", message: error.rawValue, buttonTitle: "OK")
            }
        })
    }
}

// UICollectionViewDelegate gives scrollview delegate as well as didSelect
// remember - delegates wait for us to do something
extension FollowersListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // we want the up and down coordinates (would x if you had a horizontal scrollview)
        let offsetY = scrollView.contentOffset.y
        //  get the height of the entire scroll view (all 100 followers)
        let contentHeight = scrollView.contentSize.height
        // get height of the screen
        let height = scrollView.frame.size.height
        if offsetY > contentHeight - height {
            guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let follower = !isSearching ? followers[indexPath.item] : filteredFollowers[indexPath.item]
        let desVC = UserInfoVC()
        desVC.username = follower.login
        // followers is now listening to user info modal
        desVC.delegate = self
        let navController = UINavigationController(rootViewController: desVC)
        present(navController, animated: true)
    }
}

// worth grouping delegate extensions
extension FollowersListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // user input inside search bar is unwrapped and not empty
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredFollowers.removeAll()
            updateData(on: followers)
            isSearching = false
            return
        }

        isSearching = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
    }

    func resetScreen(_ username: String) {
        title = username
        page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        // scroll and animate to very top (before was only on second row)
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    }
}

extension FollowersListVC: UserInfoVCDelegate {
    func didRequestFollowers(for username: String) {
        self.username = username
        resetScreen(username)
        getFollowers(username: username, page: page)
    }
}
