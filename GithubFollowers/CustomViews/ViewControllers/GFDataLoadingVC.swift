//
//  GFDataLoadingVC.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 2/13/22.
//

import UIKit

// workaround for creating a variable inside an extension
// it's "global" but contained within this file

class GFDataLoadingVC: UIViewController {
    var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func showLoadingView() {
        // loading view will fill up screen
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)

        containerView.backgroundColor = .systemBackground
        // make containerView transparent, so we can animate a fade in
        containerView.alpha = 0

        // fade in
        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }

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
            self.containerView?.removeFromSuperview()
            // remove from memory, release any references
            self.containerView = nil
        }
    }

    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        DispatchQueue.main.async { view.addSubview(emptyStateView) }
    }
}
