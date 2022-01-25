//
//  File.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 1/24/22.
//

import Foundation

class NetworkManager {
    // create singleton
    static let shared = NetworkManager()
    // make init private, so cannot be created outside
    private init() {}

    let baseUrl = "https://api.github.com/users"
    let perPageFollowers = 100

    // completed = closure = completionHandler = callback
    // follower needs to be optional as could return error
    // In turn, the error would be a string
    func getFollowers(for username: String, page: Int, completed: @escaping ([Follower]?, String?) -> Void) {
        let endpoint = baseUrl + "/\(username)/followers?page=\(page)&per_page=\([perPageFollowers])"
        guard let url = URL(string: endpoint) else {
            completed(nil, "This url created an invalid request, please try again")
            return
        }

        // This is the basic, native pre-swift 5 way
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // generally internet isn't corrected
            // general description but perhaps still better than error.localizedDescription
            if error != nil {
                completed(nil, "Unable to complete your request. Please check your internet connection.")
                return
            }
            // error in case of 404, 403, etc.
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "Invalid response from the server. Please try again.")
                return
            }
            guard let data = data else {
                completed(nil, "The data received from the server was invalid. Please try again.")
                return
            }
            do {
				// from Swift 4.23 with Codable
                let decoder = JSONDecoder()
                // allow from snake case
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(followers, nil)
            } catch {
                completed(nil, "The data received from the server was invalid. Please try again.")
            }
        }
        // 👀 Remember to resume the task! Easy to forget. Otherwise nothing will happen.
        task.resume()
    }
}
