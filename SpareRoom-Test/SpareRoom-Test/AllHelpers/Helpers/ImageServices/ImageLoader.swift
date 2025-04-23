//
//  ImageLoader.swift
//  SpareRoom-Test
//
//  Created by Shamil Imanov on 20.04.2025.
//

import UIKit

final class ImageLoader {
	private let cache = ImageCache.shared
	
	func loadImage(
		urlString: String,
		completion: @escaping (UIImage?) -> Void
	) {
		if let cachedImage = cache.object(forKey: urlString as NSString) {
			completion(cachedImage)
			return
		}
		
		guard let url = URL(string: urlString) else {
			completion(nil)
			return
		}
		
		URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
			guard let self, let data,
				  let image = UIImage(data: data),
				  error == nil else {
				completion(nil)
				return
			}
			
			self.cache.setObject(image, forKey: urlString as NSString)
			
			DispatchQueue.main.async {
				completion(image)
			}
		}.resume()
	}
}
