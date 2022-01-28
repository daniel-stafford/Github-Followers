//
//  GFAvatarImageView.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 1/25/22.
//

import UIKit

class GFAvatarImageView: UIImageView {
	let placeholderImage = UIImage.named(Constants.avatarPlaceHolder)
	let cache = NetworkManager.shared.cache

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

    // downloading here and not network manager, as we are not handling the errors, so perhaps no need for the result type
    func downloadImage(from urlString: String) {
		// check cache for image and if there is one, set it and exit
		let cacheKey = NSString(string: urlString)
		if let image = cache.object(forKey: cacheKey) {
			self.image = image
			return
		}
		
        // we're not handling errors as our placeholder functions as an error
        guard let url = URL(string: urlString) else { return }
		// this runs on a background thread
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
			guard let self = self else {return}
			guard error == nil else { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
			// write image to cache, similar to userDefaults forKey
			self.cache.setObject(image, forKey: cacheKey)
			// back to main thread and set image
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}
