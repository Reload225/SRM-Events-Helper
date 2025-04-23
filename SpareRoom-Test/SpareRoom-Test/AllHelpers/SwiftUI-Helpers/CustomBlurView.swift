//
//  CustomBlurView.swift
//  SpareRoom-Test
//
//  Created by Shamil Imanov on 19.04.2025.
//

import UIKit
import SwiftUI

struct CustomBlurView: UIViewRepresentable {
	var effect: UIBlurEffect.Style
	
	func makeUIView(context: Context) -> UIVisualEffectView {
		let view = UIVisualEffectView(effect: UIBlurEffect(style: effect))
		return view
	}
	
	func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
