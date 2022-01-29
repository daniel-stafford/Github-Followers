//
//  GFAlertContainerView.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 1/22/22.
//

import UIKit

class GFAlertContainerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
		configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
		// zero = an edge insets struct whose top, left, bottom, and right fields are all set to 0.
        super.init(frame: .zero)
        configure()
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        layer.cornerRadius = 16
        // need or dark mode in order to pop
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
    }
}