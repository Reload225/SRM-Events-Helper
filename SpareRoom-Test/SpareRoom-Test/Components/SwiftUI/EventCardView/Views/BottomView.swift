//
//  BottomView.swift
//  SpareRoom-Test
//
//  Created by Shamil Imanov on 20.04.2025.
//

import UIKit
import SwiftUI

struct BottomView: View {
	private enum Constants {
		static let verticalSpacing: CGFloat = 8
		static let iconSpacing: CGFloat = 16
		static let horizontalPadding: CGFloat = 20
		static let dividerHeight: CGFloat = 2.0
		static let dividerOpacity: CGFloat = 0.8
		static let verticalPadding: CGFloat = 20
		static let gradientStops: [Gradient.Stop] = [
			Gradient.Stop(color: .white.opacity(1), location: 0.6),
			Gradient.Stop(color: .white.opacity(0.9), location: 0.7),
			Gradient.Stop(color: .white.opacity(0.7), location: 0.9),
			Gradient.Stop(color: .white.opacity(0.0), location: 1.0)
		]
		static let overlayGradientColors: [Color] = [
			.white.opacity(0.5),
			.white.opacity(0.2),
			.clear
		]
	}
	
	@State private var viewHeight: CGFloat = .zero
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
								startPoint: .bottom,
								endPoint: .top
							)
						)
					
					RoundedRectangle(cornerRadius: 0, style: .continuous)
						.fill(
							LinearGradient(
								colors: Constants.overlayGradientColors,
								startPoint: .bottom,
								endPoint: .top
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
			bottomContent()
		})
	}
	
	private func bottomContent() -> some View {
		VStack {
			HStack {
				VStack(alignment: .leading, spacing: Constants.verticalSpacing) {
					IconLabelView(
						adaptToImage: adaptToImage,
						imageName: "calendar",
						text: model.dateText
					)
					
					HStack(spacing: Constants.iconSpacing) {
						IconLabelView(
							adaptToImage: adaptToImage,
							imageName: "clock",
							text: model.timeText
						)
						.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
						.lineLimit(1)
						.fixedSize(horizontal: true, vertical: false)
						
						IconLabelView(
							adaptToImage: adaptToImage,
							imageName: "info.circle",
							text: model.infoText
						)
						.lineLimit(1)
						.frame(maxWidth: .infinity, alignment: .leading)
					}
				}
			}
			.padding(.horizontal, Constants.horizontalPadding)
			
			Divider()
				.frame(maxWidth: .infinity, idealHeight: Constants.dividerHeight)
				.background(.white.opacity(Constants.dividerOpacity))
			
			HStack {
				ButtonView(adaptToImage: adaptToImage, text: "checkIn") {
					model.checkInHandler?()
				}
				Spacer()
				ButtonView(adaptToImage: adaptToImage, text: "edit") {
					model.editHandler?()
				}
			}
			.padding(.horizontal, Constants.horizontalPadding)
		}
		.padding(.vertical, Constants.verticalPadding)
		.blendMode(adaptToImage ? .overlay : .normal)
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
	}
}
