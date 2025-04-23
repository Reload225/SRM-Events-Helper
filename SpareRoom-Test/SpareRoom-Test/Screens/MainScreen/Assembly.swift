//
//  Assembly.swift
//  SpareRoom-Test
//
//  Created by Shamil Imanov on 20.04.2025.
//

import Foundation

final class Assembly {
	static func assembly() -> ViewController {
		let viewController = ViewController()
		let interactor = Interactor(worker: Worker())
		let presenter = Presenter()
		let router = Router()

		viewController.interactor = interactor
		viewController.router = router

		interactor.presenter = presenter

		presenter.controller = viewController

		router.controller = viewController

		return viewController
	}
}
