//
//  Date+Extensions.swift
//  PhotoClock
//
//  Created by Douglas Yuen on 2021-02-03.
//

import Foundation

/*
	Holds extensions for the Date object
*/

extension Date
{
	// Returns a US POSIX-formatted date for North American use in the format "Month Day, Year"
	
	func formattedDate() -> String
	{
		let formatter = DateFormatter()
		formatter.locale = Locale(identifier: "en_US_POSIX")
		formatter.dateFormat = "MMMM dd, yyyy"

		let dateString = formatter.string(from: self)
		
		return dateString
	}

	// Returns a US POSIX-formatted time string for North American use in the format "Hour:Minute:Second Am/PM"
	// Optional boolean parameter can be passed in to determine if we're using a 12 or 24 hour clock
	
	func formattedTime(is24Hour:Bool = false) -> String
	{
		let formatter = DateFormatter()
		formatter.locale = Locale(identifier: "en_US_POSIX")
		formatter.dateFormat = is24Hour ? "HH:mm:ss": "H:mm:ss a"
		formatter.amSymbol = "AM"
		formatter.pmSymbol = "PM"
		
		let timeString = formatter.string(from: self)
		
		return timeString
	}
}
