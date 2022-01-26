//
//  GFAvatarImageView.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 1/25/22.
//

import UIKit

class GFAvatarImageView: UIImageView {
    let placeholderImage = UIImage.named("avatar-placeholder")

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        // make sure image subview is rounded as well
        clipsToBounds = true
        // placeholder image
        image = placeholderImage
    }
}
