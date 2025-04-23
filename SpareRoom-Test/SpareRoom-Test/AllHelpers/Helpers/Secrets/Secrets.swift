//
//  Secrets.swift
//  SpareRoom-Test
//
//  Created by Shamil Imanov on 21.04.2025.
//

import Foundation

enum Secrets {
	private static let obfuscated = "JDJiJDEwJFVZemgxMWh0VWVrSUdpTXU2RS5MMnVKTlU3SFFBaE9kNW1vRzJLQTdGcjFMdWlFU0lDcm9x"
	
	static var apiKey: String {
		guard let data = Data(base64Encoded: obfuscated),
			  let decoded = String(data: data, encoding: .utf8) else {
			return ""
		}
		return decoded
	}
}
