//
//  GFError.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 1/30/22.
//

import Foundation

// since we renamed this enum, created a new file to avoid any pathing issues
// Raw value is all cases conform to one type
// Associated values is after each case
// comform to error when using Result
enum GFError: String, Error {
	case invalidUsername = "This url created an invalid request, please try again."
	case unableToComplete = "Unable to complete your request. Please check your internet connection."
	case invalidResponse = "Invalid response from the server. Please try again."
	case invalidData = "The data received from the server was invalid. Please try again."
	case unableToFavorite = "There was an error favoriting this user. Please trt again."
	case alreadyInFavorites="You have already added this user. You must like them a lot! 😊"
}
