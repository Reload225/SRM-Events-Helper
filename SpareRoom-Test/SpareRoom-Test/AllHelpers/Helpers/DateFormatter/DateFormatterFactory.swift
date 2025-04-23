//
//  DateFormatterFactory.swift
//  SpareRoom-Test
//
//  Created by Shamil Imanov on 21.04.2025.
//


import Foundation

final class DateFormatterFactory {
	private static var cache: [String: DateFormatter] = [:]
	
	static func make(format: DateFormat) -> DateFormatter {
		let key = format.rawValue
		
		if let cachedFormatter = cache[key] {
			return cachedFormatter
		}
		
		let formatter = DateFormatter()
		formatter.locale = Locale(identifier: "en_US_POSIX")
		formatter.dateFormat = format.rawValue
		
		cache[key] = formatter
		return formatter
	}
}
