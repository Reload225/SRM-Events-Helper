//
//  Colors.swift
//  SpareRoom-Test
//
//  Created by Shamil Imanov on 20.04.2025.
//

import UIKit

enum Colors {
	enum Background {
		static let primary = ColorsAsset(name: "primary").color
		static let secondary = ColorsAsset(name: "secondary").color
		static let neutral = ColorsAsset(name: "neutral").color
		static let errorButton = ColorsAsset(name: "errorButton").color
	}

	enum Feature {
		static let grayishBlue = ColorsAsset(name: "grayishBlue").color
		static let segmentText = ColorsAsset(name: "segmentText").color
		static let userButtons = ColorsAsset(name: "userButtons").color
		static let defaultButtonText = ColorsAsset(name: "defaultButtonText").color
	}
}
