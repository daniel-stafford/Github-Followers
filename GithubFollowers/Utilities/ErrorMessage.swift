//
//  ErrorMessage.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 1/25/22.
//

import Foundation

// Raw value is all cases conform to one type
// Associated values is after each case
enum ErrorMessage: String {
	case invalidUsername = "This url created an invalid request, please try again."
	case unableToComplete = "Unable to complete your request. Please check your internet connection."
	case invalidResponse = "Invalid response from the server. Please try again."
	case invalidData = "The data received from the server was invalid. Please try again."
}
