//
//  GlassmorphicEventView.swift
//  SpareRoom-Test
//
//  Created by Shamil Imanov on 19.04.2025.
//

import UIKit
import SwiftUI

struct GlassmorphicEventView: View {
	@StateObject var imageLoader = ImageLoaderViewModel()
	let model: GlassmorphicEventViewModel
	
	var body: some View {
		ZStack {
			GeometryReader { geometry in
				BackgroundImageView(imageLoader: imageLoader, imageURL: model.imageURL)
					.id(model.imageURL)
					.frame(width: geometry.size.width, height: geometry.size.height)
					.clipped()
			}
			VStack {
				TopView(adaptToImage: imageLoader.image != nil, model: model)
				Spacer()
				BottomView(adaptToImage: imageLoader.image != nil, model: model)
			}
		}
	}
}
