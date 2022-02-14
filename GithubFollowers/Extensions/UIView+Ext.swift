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
}
