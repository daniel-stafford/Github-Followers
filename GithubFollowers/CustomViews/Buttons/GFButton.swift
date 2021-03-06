//
//  GFButton.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 1/22/22.
//

import UIKit

// note the GF (Github Followers) button is a means to distinguish that it's our own custom button and not from another library
class GFButton: UIButton {
    // we must override the initializer for custom config
    override init(frame: CGRect) {
        // build on top of existing class
        super.init(frame: frame)
        configure()
    }

    // gets called when initializing via storyboard
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // custom init taking background color and title
    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }

    // private - as don't want to call outside of class
    private func configure() {
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        // we want to conform to dynamic type for default SF font
        // beware of extra work with custom fonts
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        // autoLayout programmatically
        translatesAutoresizingMaskIntoConstraints = false
    }

    // allows us to change on the fly vs. more inflexible init method
    func set(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
}
