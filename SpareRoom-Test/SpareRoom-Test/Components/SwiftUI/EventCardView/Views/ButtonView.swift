//
//  ButtonView.swift
//  SpareRoom-Test
//
//  Created by Shamil Imanov on 20.04.2025.
//

import UIKit
import SwiftUI

struct ButtonView: View {
	private enum Constants {
		static let cornerRadius: CGFloat = 10
		static let blurRadius: CGFloat = 10
		static let backgroundOpacity: CGFloat = 0.3
		static let fontSize: CGFloat = 17
		static let horizontalPadding: CGFloat = 40
		static let height: CGFloat = 50
		static let overlayGradientColors: [Color] = [
			.white.opacity(0.3),
			.white.opacity(0.1),
			.clear
		]
	}
	
	@State private var textWidth: CGFloat = 0
	var buttonColor: Color?
	let adaptToImage: Bool
	let text: LocalizedStringKey
	let action: () -> Void
	
	var body: some View {
		ZStack {
			if adaptToImage {
				CustomBlurView(effect: .systemUltraThinMaterialLight)
					.clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous))
				
				RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous)
					.fill(
						LinearGradient(
							colors: Constants.overlayGradientColors,
							startPoint: .top,
							endPoint: .bottom
						)
					)
					.blur(radius: Constants.blurRadius)
			} else {
				RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous)
					.foregroundStyle(buttonColor ?? Color.gray.opacity(Constants.backgroundOpacity))
			}
		}
		.overlay(content: {
			Text(text)
				.background(
					GeometryReader { geometry in
						Color.clear
							.onAppear {
								textWidth = geometry.size.width
							}
					}
				)
				.modifier(
					CustomModifier(
						font: .system(size: Constants.fontSize, weight: .regular),
						color: adaptToImage
						? .white
						: Color(Colors.Feature.defaultButtonText),
						alignment: .center
					)
				)
				.blendMode(adaptToImage ? .overlay: .normal)
				.frame(maxWidth: .infinity, maxHeight: .infinity)
		})
		.frame(width: textWidth + Constants.horizontalPadding, height: Constants.height)
		.onTapGesture(perform: action)
	}
}
