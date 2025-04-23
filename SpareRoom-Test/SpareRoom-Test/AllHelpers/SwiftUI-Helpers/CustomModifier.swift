//
//  CustomModifier.swift
//  SpareRoom-Test
//
//  Created by Shamil Imanov on 19.04.2025.
//

import UIKit
import SwiftUI

struct CustomModifier: ViewModifier {
	var font: Font
	var color: Color
	var alignment: Alignment
	
	func body(content: Content) -> some View {
		content
			.font(font)
			.foregroundColor(color)
			.frame(maxWidth: .infinity, alignment: alignment)
	}
}
