//
//  WorkerLogic.swift
//  SpareRoom-Test
//
//  Created by Shamil Imanov on 20.04.2025.
//

import Foundation

protocol WorkerLogic {
	func fetchEvents(
		onSuccess: ((Model.EventResponse) -> Void)?,
		onError: ((Error?) -> Void)?
	)
}
