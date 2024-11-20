// The Swift Programming Language
// https://docs.swift.org/swift-book
// 
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation

import ArgumentParser
import Foundation

@main
struct FeedbinToGoodlinks: ParsableCommand {
	
	static let configuration = CommandConfiguration(
		abstract: "A tool for converting a feedbin starred.json file into an importable goodlinks file.\nWrites a converted goodlinks.json file to the same directory as the feedbin file."
	)
	
	@Option(help: "The path to a feedbin starred.json file.") var feedbinFile: String
	
    mutating func run() throws {
		let feedbinFilePath = URL(fileURLWithPath: feedbinFile)
		print(feedbinFilePath)
		let feedbinData = try Data(contentsOf: feedbinFilePath)
		let jsonDecoder = JSONDecoder()
		let feedbinItems = try jsonDecoder.decode([FeedbinItem].self, from: feedbinData)
		let goodlinksItems = feedbinItems.map {
			let convertedTime = $0.createdAt.timeIntervalSince1970
			print("Converting Date \($0.createdAt) to unix timestamp \(convertedTime)")
			return GoodlinksItem(title: $0.title, url: $0.url, addedAt: convertedTime)
		}
		let jsonEncoder = JSONEncoder()
		let goodlinksData = try jsonEncoder.encode(goodlinksItems)
		let goodlinksFilePath = feedbinFilePath.deletingLastPathComponent().appendingPathComponent("goodlinks.json")
		try goodlinksData.write(to: goodlinksFilePath)
		print("\nWrote \(goodlinksFilePath.lastPathComponent) to \(goodlinksFilePath).\n")
    }
}
