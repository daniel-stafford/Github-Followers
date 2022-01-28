//
//  UIViewController+Ext.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 1/23/22.
//

// no need to import Foundation, it's included in UIKit
import UIKit
// workaround for creating a variable inside an extension
// it's "global" but contained within this file
fileprivate var containerView: UIView!

extension UIViewController {
    func presentGFAlertOnMainThread(alertTitle: String, message: String, buttonTitle: String) {
        // show on main thread since updating UI
        // no need for capture list, e.g. weak self
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(alertTitle: alertTitle, message: message, buttonTitle: buttonTitle)
            // doesn't show card view
            alertVC.modalPresentationStyle = .overFullScreen
            // fade in animation
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }

    func showLoadingView() {
        // loading view will fill up screen
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)

        containerView.backgroundColor = .systemBackground
        // make containerView transparent, so we can animate a fade in
        containerView.alpha = 0

        // fade in
        UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8 }

        // gives size, so only need to set horizontally and vertically
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        // centered on screen
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        // begin animation upon appearing
        activityIndicator.startAnimating()
    }

    func dismissLoadingView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            // remove from memory, release any references
            containerView = nil
        }
    }
}
