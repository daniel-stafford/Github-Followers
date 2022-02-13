//
//  GFEmptyStateView.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 1/28/22.
//

import UIKit

class GFEmptyStateView: UIView {
    var messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }

    private func configure() {
        addSubview(messageLabel)
        addSubview(logoImageView)

        messageLabel.numberOfLines = 3
        // slightly faded color
        messageLabel.textColor = .secondaryLabel

		logoImageView.image = Images.emptyStateLogo
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // center vertically, slightly up
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),

            // making a square as usual and multiplier for "right look"
            logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            // pushing image to right, so no negative
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 170),
            // push down, so again no negative
            logoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 40),
        ])
    }
}
