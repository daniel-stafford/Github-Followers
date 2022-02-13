//
//  GFSecondaryTitle Label.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 2/3/22.
//

import UIKit

// not super DRY but may be easier to work with
class GFSecondaryTitleLabel: UILabel {
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	convenience init(fontSize: CGFloat) {
		self.init(frame: .zero)
		font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
	}

	private func configure() {
		translatesAutoresizingMaskIntoConstraints = false
		textColor = .secondaryLabel
		adjustsFontSizeToFitWidth = true
		minimumScaleFactor = 0.9
		lineBreakMode = .byTruncatingTail
	}
}
