//
//  GFTextField.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 1/22/22.
//

import UIKit

// even though we are using this once, declutters our view controller
class GFTextField: UITextField {
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
        layer.borderWidth = 2
        // remember to use CG color when dealing with Core Graphics
        layer.borderColor = UIColor.systemGray4.cgColor

        // label is a color, black on white mode, white on dark mode
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        // if super long title, will shrink to fit
        adjustsFontSizeToFitWidth = true
        // don't shrink past 12
        minimumFontSize = 12

        backgroundColor = .tertiarySystemBackground
        // because usernames are weird!
        autocorrectionType = .no

        placeholder = "Enter a username"
    }
}
