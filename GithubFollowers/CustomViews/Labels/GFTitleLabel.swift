//
//  GFTitleLabel.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 1/22/22.
//

import UIKit

class GFTitleLabel: UILabel {
	// designated initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
		configure()
	}

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	// convenience will call designated init on line 23, so only need to call configure() once
	// convenience can also allows to create default values for a long parameter list
	convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
		// super.init becomes self.init with convenience init
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }

    private func configure() {
		translatesAutoresizingMaskIntoConstraints = false
        textColor = .label
        adjustsFontSizeToFitWidth = true
		// only slight shrinking
		minimumScaleFactor = 0.9
		// add ... for too long title
		lineBreakMode = .byTruncatingTail
    }
}
