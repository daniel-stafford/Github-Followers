//
//  GFEmptyStateView.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 1/28/22.
//

import UIKit

class GFEmptyStateView: UIView {
    var messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 25)
    let logoImageView = UIImageView()
    var messageLabelCenterYConstraint: NSLayoutConstraint!
    var logoImageViewBottomConstraint: NSLayoutConstraint!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }

    private func configure() {
        addSubview(messageLabel)
        addSubview(logoImageView)

        messageLabel.numberOfLines = 3
        // slightly faded color
        messageLabel.textColor = .secondaryLabel

        logoImageView.image = Images.emptyStateLogo
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

		// center vertically, slightly up
        let messageLabelCenterYConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -80 : -150
        messageLabelCenterYConstraint = messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: messageLabelCenterYConstant)
        messageLabelCenterYConstraint.isActive = true

		// push down, so again no negative
        let logoImageViewBottomConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 100 : 80
        logoImageViewBottomConstraint = logoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: logoImageViewBottomConstant)
        logoImageViewBottomConstraint.isActive = true

        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),

            // making a square as usual and multiplier for "right look"
            logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            // pushing image to right, so no negative
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 170),
        ])
    }
}
