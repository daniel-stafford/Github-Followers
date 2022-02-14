//
//  UITableView+Ext.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 2/14/22.
//

import UIKit

extension UITableView {
	func  removeExcessCells() {
		tableFooterView = UIView(frame: .zero)
	}
}
