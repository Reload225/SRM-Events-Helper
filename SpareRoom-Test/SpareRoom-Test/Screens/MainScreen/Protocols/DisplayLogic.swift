//
//  DisplayLogic.swift
//  SpareRoom-Test
//
//  Created by Shamil Imanov on 20.04.2025.
//

import Foundation

protocol DisplayLogic: AnyObject {
	func displayLoader(isLoading: Bool)
	func displayData(
		upcomingModel: [GlassmorphicEventViewModel],
		pastModel: [GlassmorphicEventViewModel],
		draftModel: [GlassmorphicEventViewModel]
	)
	func displayError(isOffline: Bool)
	func displayCheckInController()
	func displayEditController()
}
