//
//  Router.swift
//  SpareRoom-Test
//
//  Created by Shamil Imanov on 20.04.2025.
//

import UIKit

final class Router: RoutingLogic {
	weak var controller: UIViewController?
	
	func routeCheckInController() {
		debugPrint("checkInHandler")
	}
	
	func routeEditController() {
		debugPrint("editHandler")
	}
}
