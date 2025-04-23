//
//  GlassmorphicViewModel.swift
//  SpareRoom-Test
//
//  Created by Shamil Imanov on 19.04.2025.
//

import UIKit

struct GlassmorphicEventViewModel {
	let imageURL: String
	let title: String
	let subtitle: String
	let dateText: String
	let timeText: String
	let infoText: String
	var checkInHandler: (() -> Void)?
	var editHandler: (() -> Void)?
}
