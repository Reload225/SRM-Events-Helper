//
//  Worker.swift
//  SpareRoom-Test
//
//  Created by Shamil Imanov on 20.04.2025.
//

import Foundation

final class Worker: WorkerLogic {
	func fetchEvents(
		onSuccess: ((Model.EventResponse) -> Void)?,
		onError: ((Error?) -> Void)?
	) {
		guard let url = URL(string: "https://api.jsonbin.io/v3/b/67f4cf228561e97a50fad7a2") else {
			onError?(NSError(domain: "Invalid URL", code: 0))
			return
		}
		
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		request.setValue(Secrets.apiKey, forHTTPHeaderField: "X-Master-Key")
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			if let error {
				onError?(error)
				return
			}
			
			guard let data else {
				onError?(NSError(domain: "No data received", code: 0))
				return
			}
			
			do {
				let decoder = JSONDecoder()
				let eventResponse = try decoder.decode(Model.EventResponse.self, from: data)
				
				DispatchQueue.main.async {
					onSuccess?(eventResponse)
				}
			} catch {
				DispatchQueue.main.async {
					onError?(error)
				}
			}
		}.resume()
	}
}
