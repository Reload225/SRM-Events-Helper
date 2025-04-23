//
//  ButtonUIView.swift
//  SpareRoom-Test
//
//  Created by Shamil Imanov on 20.04.2025.
//

import UIKit
import SwiftUI

final class ButtonUIView: UIView {
	private enum Constants {
		static let radius: CGFloat = 20
	}
	
	private var hostingController: UIHostingController<ButtonView>?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	func setModel(
		buttonText: LocalizedStringKey,
		action: (() -> Void)?
	) {
		hostingController?.rootView = ButtonView(
			buttonColor: Color(Colors.Background.errorButton),
			adaptToImage: false,
			text: buttonText,
			action: {
				action?()
			}
		)
	}
}

private extension ButtonUIView {
	func setupUI() {
		let buttonView = ButtonView(
			buttonColor: Color(Colors.Background.errorButton),
			adaptToImage: false,
			text: "",
			action: {}
		)
		
		hostingController = UIHostingController(rootView: buttonView)
		
		if let hostingView = hostingController?.view {
			hostingView.translatesAutoresizingMaskIntoConstraints = false
			addSubview(hostingView)
			
			NSLayoutConstraint.activate([
				hostingView.topAnchor.constraint(equalTo: topAnchor),
				hostingView.bottomAnchor.constraint(equalTo: bottomAnchor),
				hostingView.leadingAnchor.constraint(equalTo: leadingAnchor),
				hostingView.trailingAnchor.constraint(equalTo: trailingAnchor)
			])
			
			hostingView.clipsToBounds = true
			hostingView.backgroundColor = .clear
			hostingView.layer.cornerRadius = Constants.radius
		}
	}
}
