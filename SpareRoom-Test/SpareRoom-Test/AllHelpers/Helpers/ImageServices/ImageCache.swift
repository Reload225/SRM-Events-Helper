//
//  ImageCache.swift
//  SpareRoom-Test
//
//  Created by Shamil Imanov on 20.04.2025.
//

import UIKit

final class ImageCache {
	static let shared = ImageCache()
	private let cache = NSCache<NSString, UIImage>()
	
	private init() {}
	
	func object(forKey key: NSString) -> UIImage? {
		return cache.object(forKey: key)
	}
	
	func setObject(_ image: UIImage, forKey key: NSString) {
		cache.setObject(image, forKey: key)
	}
}
