//
//  ContentViewModel.swift
//  OpenTextTools
//
//  Created by Ian Manor on 17/02/21.
//

import Foundation

class ContentViewModel: ObservableObject {
    // MARK: Properties
    @Published var text = ""
    @Published var regex = ""
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

    // MARK: Functions
    func apply(_ transform: TextTransform) {
        transformedText = text.transform(transform)
        showTransforms = true
    }
}
