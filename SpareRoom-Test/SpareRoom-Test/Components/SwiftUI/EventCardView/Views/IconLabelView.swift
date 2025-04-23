//
//  IconLabelView.swift
//  SpareRoom-Test
//
//  Created by Shamil Imanov on 19.04.2025.
//

import UIKit
import SwiftUI

struct IconLabelView: View {
	private enum Constants {
		static let spacing: CGFloat = 16
		static let iconSize: CGFloat = 20
		static let fontSize: CGFloat = 16
		static let textOpacity: CGFloat = 0.5
		static let imageOpacity: CGFloat = 0.4
	}
	
	let adaptToImage: Bool
	let imageName: String
	let text: String
	
	var body: some View {
		HStack(spacing: Constants.spacing) {
			Image(systemName: imageName)
				.resizable()
				.scaledToFit()
				.blendMode(adaptToImage ? .overlay : .hardLight)
				.foregroundStyle(
					adaptToImage
					? .white
					: Color(Colors.Feature.grayishBlue)
						.opacity(Constants.imageOpacity))
				.frame(width: Constants.iconSize, height: Constants.iconSize)
			
			Text(text)
				.modifier(
					CustomModifier(
						font: .system(
							size: Constants.fontSize,
							weight: .regular
						),
						color: adaptToImage
						? .white
						: Color(Colors.Feature.grayishBlue),
						alignment: .topLeading
					)
				)
		}
	}
}
