//
//  UICollectionViewCell.swift
//  SpareRoom-Test
//
//  Created by Shamil Imanov on 20.04.2025.
//

import UIKit

extension UICollectionViewCell {
	static var reuseIdentifier: String {
		return String(describing: self)
	}
}
