//
//  Date+Ext.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 2/6/22.
//

import Foundation

extension Date {
	func convertToMonthYearFormat() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MMM yyyy"
		return dateFormatter.string(from: self)
	}
}
