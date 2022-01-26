//
//  FollowerCell.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 1/25/22.
//

import UIKit

class GFFollowerCell: UICollectionViewCell {
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)

    // same as storyboard identifier
    static let reuseID = "FollowerCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	// func to fill in details.  Alternative to using init
    func set(follower: Follower) {
        usernameLabel.text = follower.login
    }

    private func configure() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)

        let padding: CGFloat = 8
		
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            // we want a square, so height = weight
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),

            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            // give labels a bit of padding (16 fontSize + 4 point padding for "jgy"
            usernameLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
