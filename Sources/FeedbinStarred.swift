//
//  File.swift
//  feedbin-to-goodlinks
//
//  Created by Alan Zeino on 11/19/24.
//

import Foundation

struct FeedbinItem: Decodable {
	let title: String
	let url: URL
	let createdAt: Date
	
	enum CodingKeys: String, CodingKey {
		case title
		case url
		case createdAt = "created_at"
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		title = try container.decode(String.self, forKey: .title)
		url = try container.decode(URL.self, forKey: .url)
		
		let iso8601String = try container.decode(String.self, forKey: .createdAt)
		
		let isoFormatter = ISO8601DateFormatter()
		isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
		createdAt = isoFormatter.date(from: iso8601String)!
	}
}
