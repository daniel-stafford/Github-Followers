//
//  UIViewController+Ext.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 1/23/22.
//

// no need to import Foundation, it's included in UIKit
import UIKit

extension UIViewController {
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        // show on main thread since updating UI
        // no need for capture list, e.g. weak self
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle)
            // doesn't show card view
            alertVC.modalPresentationStyle = .overFullScreen
            // fade in animation
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}