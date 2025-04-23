//
//  Presenter.swift
//  SpareRoom-Test
//
//  Created by Shamil Imanov on 20.04.2025.
//

import Foundation

final class Presenter: PresentationLogic {
	weak var controller: DisplayLogic?
	
	func presentLoader(isLoading: Bool) {
		controller?.displayLoader(isLoading: isLoading)
	}
	
	func presentData(model: [Model.EventModel]) {
		var upcomingModel: [GlassmorphicEventViewModel] = []
		var pastModel: [GlassmorphicEventViewModel] = []
		var draftModel: [GlassmorphicEventViewModel] = []
		
		model.forEach { event in
			guard let dateModel = formatEventDateTime(startTime: event.startTime, endTime: event.endTime) else { return }
			
			let viewModel = makeViewModel(eventMode: event, dateModel: dateModel)
			
			switch event.status {
			case .published:
				if dateModel.startDate >= Date.now {
					upcomingModel.append(viewModel)
				} else {
					pastModel.append(viewModel)
				}
			case .draft:
				draftModel.append(viewModel)
			}
		}
		
		controller?.displayData(
			upcomingModel: upcomingModel,
			pastModel: pastModel,
			draftModel: draftModel
		)
	}
	
	func presentError(isOffline: Bool) {
		controller?.displayError(isOffline: isOffline)
	}
}

private extension Presenter {
	func makeViewModel(
		eventMode: Model.EventModel, 
		dateModel: Model.DateModel
	) -> GlassmorphicEventViewModel {
		GlassmorphicEventViewModel(
			imageURL: eventMode.imageUrl,
			title: eventMode.venue,
			subtitle: eventMode.location,
			dateText: dateModel.dateString,
			timeText: "\(dateModel.startTime) – \(dateModel.endTime)",
			infoText: eventMode.cost,
			checkInHandler: { [weak self] in
				guard let self else { return }
				controller?.displayCheckInController()
			},
			editHandler: { [weak self] in
				guard let self else { return }
				controller?.displayEditController()
			}
		)
	}
}

private extension Presenter {
	func formatEventDateTime(startTime: String, endTime: String) -> Model.DateModel? {
		let inputFormatter = DateFormatterFactory.make(format: .yyyMMddHHmmss)
		
		guard let startDate = inputFormatter.date(from: startTime),
			  let endDate = inputFormatter.date(from: endTime) else {
			return nil
		}
		
		let dateDayString = formatDate(date: startDate)
		let startTimeString = formatTime(date: startDate)
		let endTimeString = formatTime(date: endDate)
		
		let model = Model.DateModel(
			startDate: startDate,
			dateString: dateDayString,
			startTime: startTimeString,
			endTime: endTimeString
		)
		return model
	}
	
	func formatDate(date: Date) -> String {
		let dateFormatter = DateFormatterFactory.make(format: .MMMMdyyyy)
		return dateFormatter.string(from: date)
	}
	
	func formatTime(date: Date) -> String {
		let timeFormatter = DateFormatterFactory.make(format: .hmma)
		
		var time = timeFormatter.string(from: date)
		time = time.replacingOccurrences(of: " ", with: "")
		time = time.replacingOccurrences(of: ":00", with: "")
		return time
	}
}
