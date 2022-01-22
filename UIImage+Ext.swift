//
//  UIImage+Ext.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 1/23/22.
//

import UIKit

extension UIImage {
    static func named(_ name: String) -> UIImage {
        if let image = UIImage(named: name) {
            return image
        } else {
            fatalError("Could not initialize \(UIImage.self) named \(name).")
        }
    }
}
