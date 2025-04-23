//
//  ColorsAsset.swift
//  SpareRoom-Test
//
//  Created by Shamil Imanov on 20.04.2025.
//

import UIKit

struct ColorsAsset {
	private let name: String

	var color: UIColor {
		guard let color = UIColor(named: name, in: BundleToken.bundle, compatibleWith: nil) else {
			fatalError("Unable to load image asset named \(name)")
		}

		return color
	}

	init(name: String) {
		self.name = name
	}
}
