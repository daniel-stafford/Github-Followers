//
//  GFAvatarImageView.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 1/25/22.
//

import UIKit

class GFAvatarImageView: UIImageView {
    let placeholderImage = UIImage.named("avatar-placeholder")

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
        // make sure image subview is rounded as well
        clipsToBounds = true
        // placeholder image
        image = placeholderImage
    }

    // downloading here and not network manager
    func downloadImage(from urlString: String) {
        // we're not handling errors as our placeholder functions as an error
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil { return }
			print("starting task", url)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}
