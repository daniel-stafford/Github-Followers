//
//  User.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 1/24/22.
//

import Foundation

struct User: Codable {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let followers: Int
    let following: Int
	// was originally a string but we're using .dateDecodingStrategy
	let createdAt: Date
}
