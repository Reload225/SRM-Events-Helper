//
//  EventCard.swift
//  SpareRoom-Test
//
//  Created by Shamil Imanov on 20.04.2025.
//

import UIKit
import SwiftUI

class EventCard: UICollectionViewCell {
	private enum Constants {
		static let radius: CGFloat = 20
	}
	private var hostingController: UIHostingController<GlassmorphicEventView>?

	private let emptyModel = GlassmorphicEventViewModel(
		imageURL: "",
		title: "",
		subtitle: "",
		dateText: "",
		timeText: "",
		infoText: ""
	)

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		hostingController?.rootView = GlassmorphicEventView(model: emptyModel)
	}

	func setModel(_ model: GlassmorphicEventViewModel) {
		hostingController?.rootView = GlassmorphicEventView(model: model)
	}
}

private extension EventCard {
	func setupUI() {
		let glassmorphicView = GlassmorphicEventView(model: emptyModel)

		hostingController = UIHostingController(rootView: glassmorphicView)

		if let hostingView = hostingController?.view {
			hostingView.translatesAutoresizingMaskIntoConstraints = false
			contentView.addSubview(hostingView)

			NSLayoutConstraint.activate([
				hostingView.topAnchor.constraint(equalTo: contentView.topAnchor),
				hostingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
				hostingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
				hostingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
			])

			hostingView.clipsToBounds = true
			hostingView.backgroundColor = .clear
			hostingView.layer.cornerRadius = Constants.radius
		}
	}
}
