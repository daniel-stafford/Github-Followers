//
//  UIView+Ext.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 2/14/22.
//

import UIKit

extension UIView {
    /// ... turns parameters into array (variadic)
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }

	// useful for future projects!
	func pinToEdges(of superview: UIView) {
		translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			topAnchor.constraint(equalTo: superview.topAnchor),
			leadingAnchor.constraint(equalTo: superview.leadingAnchor),
			trailingAnchor.constraint(equalTo: superview.trailingAnchor),
			bottomAnchor.constraint(equalTo: superview.bottomAnchor)
		])
	}
}
