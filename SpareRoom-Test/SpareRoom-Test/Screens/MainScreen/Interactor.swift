//
//  Interactor.swift
//  SpareRoom-Test
//
//  Created by Shamil Imanov on 20.04.2025.
//

import Foundation

final class Interactor: BusinessLogic {
	var presenter: PresentationLogic?
	
	private let worker: WorkerLogic
	
	init(worker: WorkerLogic) {
		self.worker = worker
	}
	
	func initialize() {
		loadEvents()
	}
	
	func didTapRetry() {
		loadEvents()
	}
}

private extension Interactor {
	func loadEvents() {
		presenter?.presentLoader(isLoading: true)
		worker.fetchEvents { [weak self] model in
			guard let self else { return }
			self.presenter?.presentLoader(isLoading: false)
			self.presenter?.presentData(model: model.record)
		} onError: { [weak self] error in
			guard let self else { return }
			self.presenter?.presentLoader(isLoading: false)
			if let error = error as? URLError,
			   error.code == .notConnectedToInternet {
				self.presenter?.presentError(isOffline: true)
			} else {
				self.presenter?.presentError(isOffline: false)
			}
		}
	}
}
