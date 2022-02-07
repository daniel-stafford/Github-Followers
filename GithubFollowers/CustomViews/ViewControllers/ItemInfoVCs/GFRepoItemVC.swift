//
//  GFRepoItemVC.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 2/5/22.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
    override func viewDidLoad() {
        super.viewDidLoad()
		configureItems()
    }

    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
	
	override func actionButtonTapped() {
		delegate.didTapGithubProfile(for: user)
	}
}
