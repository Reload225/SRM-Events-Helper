//
//  String+Localized.swift
//  SpareRoom-Test
//
//  Created by Shamil Imanov on 20.04.2025.
//

import Foundation

extension String {
	var localized: String {
		return NSLocalizedString(self, comment: String())
	}
}
