//
//  ErrorModel.swift
//  SpareRoom-Test
//
//  Created by Shamil Imanov on 20.04.2025.
//

import UIKit

struct ErrorModel {
	let icon: UIImage?
	let title: String
	let text: String
	let retryHandle: (() -> Void)?
}
