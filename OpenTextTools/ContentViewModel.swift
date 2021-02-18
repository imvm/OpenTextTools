//
//  ContentViewModel.swift
//  OpenTextTools
//
//  Created by Ian Manor on 17/02/21.
//

import Foundation
import Regex

class ContentViewModel: ObservableObject {
    // MARK: Properties
    @Published var text = ""
    @Published var regex = ""
    @Published var showRegexMatches = false
    @Published var transformedText = ""
    @Published var showTransforms = false
    @Published var transformHeight = Constants.maxTransformHeight

    private let timeFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        return formatter
    }()

    var formattedReadingTime: String {
        timeFormatter.string(from: NSNumber(value: Analyzer.readingTime(text: text)))!
    }

    var formattedSpeakingTime: String {
        timeFormatter.string(from: NSNumber(value: Analyzer.speakingTime(text: text)))!
    }

    var regexMatches: [Range<String.Index>] {
        guard let regex = try? Regex(regex) else { return [] }
        let matches = regex.matches(in: text)
        return matches.map(\.range)
    }

    // MARK: Functions
    func apply(_ transform: TextTransform) {
        transformedText = text.transform(transform)
        showTransforms = true
    }
}

extension Regex.Match {
    var range: Range<String.Index> {
        (fullMatch.startIndex..<fullMatch.endIndex)
    }
}
