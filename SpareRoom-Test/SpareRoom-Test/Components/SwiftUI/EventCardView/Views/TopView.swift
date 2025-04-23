//
//  TopView.swift
//  SpareRoom-Test
//
//  Created by Shamil Imanov on 20.04.2025.
//

import UIKit
import SwiftUI

struct TopView: View {
	private enum Constants {
		static let verticalSpacing: CGFloat = 2
		static let titleFontSize: CGFloat = 15
		static let titleOpacityLight: CGFloat = 0.5
		static let titleOpacityDark: CGFloat = 0.3
		static let subtitleFontSize: CGFloat = 34
		static let subtitleOpacityLight: CGFloat = 0.7
		static let subtitleOpacityDark: CGFloat = 0.5
		static let padding: CGFloat = 20
		static let gradientStops: [Gradient.Stop] = [
			.init(color: .white.opacity(1), location: 0.2),
			.init(color: .white.opacity(0.8), location: 0.3),
			.init(color: .white.opacity(0.6), location: 0.5),
			.init(color: .white.opacity(0.0), location: 1.0)
		]
		static let overlayGradientColors: [Color] = [
			.white.opacity(0.7),
			.white.opacity(0.3),
			.clear
		]
	}
	
	let adaptToImage: Bool
	let model: GlassmorphicEventViewModel
	
	var body: some View {
		ZStack {
			if adaptToImage {
				ZStack {
					CustomBlurView(effect: .systemUltraThinMaterialDark)
						.mask(
							LinearGradient(
								gradient: Gradient(stops: Constants.gradientStops),
								startPoint: .top,
								endPoint: .bottom
							)
						)
					RoundedRectangle(cornerRadius: 0, style: .continuous)
						.fill(
							LinearGradient(
								colors: Constants.overlayGradientColors,
								startPoint: .top,
								endPoint: .bottom
							)
						)
						.blendMode(.overlay)
				}
			} else {
				RoundedRectangle(cornerRadius: 0, style: .continuous)
					.fill(.clear)
			}
		}
		.overlay(content: {
			topContent()
		})
	}
	
	private func topContent() -> some View {
		VStack(alignment: .leading, spacing: Constants.verticalSpacing) {
			Text(model.title)
				.font(.system(size: Constants.titleFontSize, weight: .semibold))
				.foregroundColor(
					adaptToImage
					? .white.opacity(Constants.titleOpacityLight)
					: Color(Colors.Feature.grayishBlue).opacity(Constants.titleOpacityDark)
				)
			
			Text(model.subtitle)
				.font(.system(size: Constants.subtitleFontSize, weight: .bold))
				.foregroundColor(
					adaptToImage
					? .white.opacity(Constants.subtitleOpacityLight)
					: Color(Colors.Feature.grayishBlue)
				)
				.lineLimit(2)
		}
		.padding(Constants.padding)
		.blendMode(adaptToImage ? .overlay : .normal)
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
	}
}
