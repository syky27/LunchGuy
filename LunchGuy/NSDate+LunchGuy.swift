//
//  NSDate+LunchGuy.swift
//  LunchGuy
//
//  Created by Tomas Sykora, jr. on 24/05/16.
//  Copyright © 2016 AJTY, s.r.o. All rights reserved.
//

import Foundation

public extension Date {
	public static func ISOStringFromDate(_ date: Date) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "en_US_POSIX")
		dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"

		return dateFormatter.string(from: date) + "Z"
	}

	public static func dateFromISOString(_ string: String) -> Date {
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "en_US_POSIX")
		dateFormatter.timeZone = TimeZone.autoupdatingCurrent
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

		if let date = dateFormatter.date(from: string) {
			return date
		}

		return Date()

	}
}
