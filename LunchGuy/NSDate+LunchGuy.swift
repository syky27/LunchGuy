//
//  NSDate+LunchGuy.swift
//  LunchGuy
//
//  Created by Tomas Sykora, jr. on 24/05/16.
//  Copyright © 2016 AJTY, s.r.o. All rights reserved.
//

import Foundation

public extension NSDate {
	public class func ISOStringFromDate(date: NSDate) -> String {
		let dateFormatter = NSDateFormatter()
		dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
		dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT")
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"

		return dateFormatter.stringFromDate(date).stringByAppendingString("Z")
	}

	public class func dateFromISOString(string: String) -> NSDate {
		let dateFormatter = NSDateFormatter()
		dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
		dateFormatter.timeZone = NSTimeZone.localTimeZone()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

		if let date = dateFormatter.dateFromString(string) {
			return date
		}

		return NSDate()

	}
}