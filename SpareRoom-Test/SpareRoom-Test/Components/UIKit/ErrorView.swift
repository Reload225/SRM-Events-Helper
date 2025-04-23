//
//  ErrorView.swift
//  SpareRoom-Test
//
//  Created by Shamil Imanov on 20.04.2025.
//


import UIKit

final class ErrorView: UIView {
	private enum Constants {
		static let iconWidth: CGFloat = 55
		static let iconHeight: CGFloat = 25
		static let titleTopPadding: CGFloat = 20
		static let horizontalPadding: CGFloat = 16
		static let descriptionTopPadding: CGFloat = 4
		static let buttonTopPadding: CGFloat = 16
		static let buttonWidth: CGFloat = 90
		static let buttonHeight: CGFloat = 50
	}
	
	private let errorIcon = UIImageView()
	private let errorTitle = UILabel()
	private let errorDescription = UILabel()
	private let retryButton = ButtonUIView()
	private var retryHandle: (() -> Void)?
	
	init() {
		super.init(frame: .zero)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	func setModel(_ model: ErrorModel) {
		errorIcon.image = model.icon
		errorTitle.text = model.title
		errorDescription.text = model.text
		retryHandle = {
			model.retryHandle?()
		}
	}
}

private extension ErrorView {
	func setupUI() {
		[
			errorIcon,
			errorTitle,
			errorDescription,
			retryButton
		].forEach { view in
			addSubview(view)
			view.translatesAutoresizingMaskIntoConstraints = false
		}
		
		setupConstraints()
		setupAppearance()
	}
	
	func setupConstraints() {
		NSLayoutConstraint.activate([
			errorIcon.topAnchor.constraint(equalTo: topAnchor),
			errorIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
			errorIcon.widthAnchor.constraint(equalToConstant: Constants.iconWidth),
			errorIcon.heightAnchor.constraint(equalToConstant: Constants.iconHeight),
			
			errorTitle.topAnchor.constraint(equalTo: errorIcon.bottomAnchor, constant: Constants.titleTopPadding),
			errorTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.horizontalPadding),
			errorTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.horizontalPadding),
			
			errorDescription.topAnchor.constraint(equalTo: errorTitle.bottomAnchor, constant: Constants.descriptionTopPadding),
			errorDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.horizontalPadding),
			errorDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.horizontalPadding),
			
			retryButton.topAnchor.constraint(equalTo: errorDescription.bottomAnchor, constant: Constants.buttonTopPadding),
			retryButton.bottomAnchor.constraint(equalTo: bottomAnchor),
			retryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
			retryButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
			retryButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
		])
	}
	
	func setupAppearance() {
		errorDescription.numberOfLines = 0
		[errorTitle, errorDescription].forEach { label in
			label.textAlignment = .center
			label.textColor = Colors.Feature.grayishBlue
		}
		errorIcon.contentMode = .scaleAspectFill
		errorIcon.tintColor = Colors.Feature.grayishBlue
		
		retryButton.setModel(buttonText: "retry") { [weak self] in
			guard let self else { return }
			self.retryHandle?()
		}
	}
}
