//
//  GoodlinksImport.swift
//  feedbin-to-goodlinks
//
//  Created by Alan Zeino on 11/19/24.
//

import Foundation

struct GoodlinksItem: Encodable {
	let title: String
	let url: URL
	let addedAt: TimeInterval
	let starred = false
	let tags: [String] = []
}
