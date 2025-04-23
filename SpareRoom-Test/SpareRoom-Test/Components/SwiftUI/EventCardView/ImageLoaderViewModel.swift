//
//  ImageLoaderViewModel.swift
//  SpareRoom-Test
//
//  Created by Shamil Imanov on 20.04.2025.
//


import SwiftUI
import Combine

final class ImageLoaderViewModel: ObservableObject {
	@Published var image: UIImage? = nil
	@Published var isLoading: Bool = true
	private let imageLoader = ImageLoader()
	
	func loadImage(from urlString: String) {
		isLoading = true
		imageLoader.loadImage(urlString: urlString) { [weak self] loadedImage in
			guard let self else { return }
			self.image = loadedImage
			self.isLoading = false
		}
	}
}
