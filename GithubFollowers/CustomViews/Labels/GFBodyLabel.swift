//
//  GFBodyLabel.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 1/22/22.
//

import UIKit

class GFBodyLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
		configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

   convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.preferredFont(forTextStyle: .body)
		// allow for dynamic type
		adjustsFontForContentSizeCategory = true
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        // set number of lines in VC
        lineBreakMode = .byWordWrapping
    }
}
