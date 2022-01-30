//
//  Follower.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 1/24/22.
//

import Foundation

// follower is hashable as all our properties are strings
struct Follower: Codable, Hashable {
    // remember to match variable names with JSON structure when using Codable (not using wrappers)
    // not making optional since they cannot be nil - not going to worry about crazy edge cases for now
    let login: String
    // JSON decoder can convert from snake_case, so okay to use avatarUrl for avatar_url
    let avatarUrl: String

    // not necessary but worth being aware of
    func hash(into hasher: inout Hasher) {
        hasher.combine(login)
    }
}
