//
//  UIHelper.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 1/27/22.
//

import UIKit

struct UIHelper {
	
	static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
		// full width of screen
		let width = view.bounds.width
		// UI edge insets
		let padding: CGFloat = 12
		// spacing between cells
		let minimumItemSpacing: CGFloat = 10
		let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
		let itemWidth = availableWidth / 3

		let flowLayout = UICollectionViewFlowLayout()
		// could refactor to use extension
		flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
		// make height dynamic + some space for the usernameLabel
		flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)

		return flowLayout
	}
}
