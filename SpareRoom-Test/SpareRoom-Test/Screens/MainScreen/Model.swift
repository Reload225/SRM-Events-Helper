//
//  Model.swift
//  SpareRoom-Test
//
//  Created by Shamil Imanov on 20.04.2025.
//

import Foundation
import UIKit

enum Model {
	struct EventResponse: Decodable {
		let record: [EventModel]
	}
	
	struct EventModel: Decodable {
		let imageUrl: String
		let cost: String
		let location: String
		let venue: String
		let startTime: String
		let endTime: String
		let status: EventStatus
	}

	enum EventStatus: String, Decodable {
		case published
		case draft
	}

	struct DateModel {
		let startDate: Date
		let dateString: String
		let startTime: String
		let endTime: String
	}

	struct SegmentScrollState {
		var offset: CGFloat = 0
		var currentPage: Int = 0
	}

	enum ScreenState {
		case loading
		case content
		case error(isOffline: Bool)
	}
}
