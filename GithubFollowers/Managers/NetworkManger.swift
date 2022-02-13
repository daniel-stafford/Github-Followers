//
//  File.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 1/24/22.
//

import UIKit

class NetworkManager {
    // create singleton
    static let shared = NetworkManager()
    // make init private, so cannot be created outside
    private init() {}

    private let baseUrl = "https://api.github.com/users"
	// create a singular cache
	let cache = NSCache<NSString, UIImage>()

    // completed = closure = completionHandler = callback
    // follower needs to be optional as could return error, in turn, the error would be a string
	// escaping - used for async function, completion handle can outlive the function, why we need to use weak self, since it will be living in memory
	// closures are non-escaping by default
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) {
		let endpoint = baseUrl + "/\(username)/followers?page=\(page)&per_page=\(Constants.maxFollowersPerPage)"

        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }

        // This is the basic, native pre-swift 5 way
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // generally internet isn't corrected
            // general description but perhaps still better than error.localizedDescription
            if error != nil {
                completed(.failure(.unableToComplete))
                return
            }
            // error in case of 404, 403, etc.
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                // from Swift 4.23 with Codable
                let decoder = JSONDecoder()
                // allow from snake case
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            } catch {
                // errors from localizedDescription are often not user friendly and targeted toward devs, hence our custom errors
				print("💀 error in getFollowers call", error)
                completed(.failure(.invalidData))
            }
        }
        // 👀 Remember to resume the task! Easy to forget. Otherwise nothing will happen.
        task.resume()
    }
	
	// OK that we're copy in pasting, typical for api calls
	func getUserInfo(for username: String, completed: @escaping (Result<User, GFError>) -> Void) {
		let endpoint = baseUrl + "/\(username)"

		guard let url = URL(string: endpoint) else {
			completed(.failure(.invalidUsername))
			return
		}

		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			if error != nil {
				completed(.failure(.unableToComplete))
				return
			}
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
				completed(.failure(.invalidResponse))
				return
			}
			guard let data = data else {
				completed(.failure(.invalidData))
				return
			}
			do {
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				// take date from standard string format
				decoder.dateDecodingStrategy = .iso8601
				let user = try decoder.decode(User.self, from: data)
				
				completed(.success(user))
			} catch {
				completed(.failure(.invalidData))
			}
		}
		task.resume()
	}
}
