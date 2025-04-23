//
//  PresentationLogic.swift
//  SpareRoom-Test
//
//  Created by Shamil Imanov on 20.04.2025.
//

import Foundation

protocol PresentationLogic: AnyObject {
	func presentLoader(isLoading: Bool)
	func presentData(model: [Model.EventModel])
	func presentError(isOffline: Bool)
}
