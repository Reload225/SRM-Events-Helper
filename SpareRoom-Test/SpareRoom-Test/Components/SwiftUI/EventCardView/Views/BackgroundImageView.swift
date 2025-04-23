//
//  BackgroundImageView.swift
//  SpareRoom-Test
//
//  Created by Shamil Imanov on 20.04.2025.
//

import UIKit
import SwiftUI

struct BackgroundImageView: View {
	private enum Constants {
		static let imageViewOpacity: CGFloat = 0.5
		static let emptyImageSize = CGSize(width: 55, height: 45)
		static let rigthBottomRadius: CGFloat = 20
		static let rigthBottomColors: [Color] = [
			.clear,
			Color(Colors.Background.neutral).opacity(0.1),
			Color(Colors.Background.neutral).opacity(0.4),
			Color(Colors.Background.neutral).opacity(1)
		]
		static let rigthBottomMaskColors: [Color] = [
			.white.opacity(0),
			.white.opacity(1)
		]
	}
	
	@ObservedObject var imageLoader: ImageLoaderViewModel
	let imageURL: String
	
	var body: some View {
		ZStack {
			if imageLoader.isLoading {
				ProgressView()
					.progressViewStyle(CircularProgressViewStyle(tint: Color(Colors.Feature.grayishBlue)))
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.background(Color(Colors.Background.secondary).opacity(Constants.imageViewOpacity))
			} else if let image = imageLoader.image {
				Image(uiImage: image)
					.resizable()
					.scaledToFill()
			} else {
				Color(Colors.Background.secondary)
				
				Image(systemName: "photo")
					.resizable()
					.scaledToFit()
					.frame(width: Constants.emptyImageSize.width, height: Constants.emptyImageSize.height)
					.foregroundStyle(Color.gray.opacity(Constants.imageViewOpacity))
			}
			
			RoundedRectangle(cornerRadius: Constants.rigthBottomRadius)
				.fill(
					LinearGradient(
						colors: Constants.rigthBottomColors,
						startPoint: .topLeading,
						endPoint: .bottomTrailing
					)
				)
				.mask(
					RoundedRectangle(cornerRadius: Constants.rigthBottomRadius)
						.fill(
							LinearGradient(
								colors: Constants.rigthBottomMaskColors,
								startPoint: .topLeading,
								endPoint: .bottomTrailing
							)
						)
				)
				.blendMode(.softLight)
		}
		.onAppear {
			imageLoader.loadImage(from: imageURL)
		}
	}
}
