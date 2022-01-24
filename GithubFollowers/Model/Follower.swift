//
//  Follower.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 1/24/22.
//

import Foundation

struct Follower: Codable {
	// remember to match variable names with JSON structure when using Codable (not using wrappers)
	// not making optional since they cannot be nil - not going to worry about crazy edge cases for now
	var login: String
	// JSON decoder can convert from snake_case, so okay to use avatarUrl for avatar_url
	var avatarUrl: String
}
