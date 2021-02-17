//
//  TextAnalyzer.swift
//  OpenTextTools
//
//  Created by Ian Manor on 06/02/21.
//

import Foundation
import NaturalLanguage
import SyllableCounter

class Analyzer {
    static func characterCount(text: String) -> Int {
        let scalars = text.unicodeScalars.compactMap { scalar in
            CharacterSet.whitespacesAndNewlines.contains(scalar) ? nil : scalar
        }

        return String(scalars).count
    }

    static func words(_ text: String) -> [String] {
        text.components(separatedBy: .whitespacesAndNewlines).compactMap({ $0.isEmpty ? nil : $0 })
    }

    static func wordCount(text: String) -> Int {
        words(text).count
    }

    static func sentences(_ text: String) -> [String] {
        var result: [String] = []
        let tagger = NLTagger(tagSchemes: [.lexicalClass])
        tagger.string = text
        tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: .sentence, scheme: .lexicalClass) { (tag, tokenRange) -> Bool in
            result.append(String(text[tokenRange]))
            return true
        }
        return result
    }

    static func sentenceCount(text: String) -> Int {
        sentences(text).count
    }

    static func paragraphs(_ text: String) -> [String] {
        fatalError()
    }

    static func paragraphCount(text: String) -> Int {
        text.components(separatedBy: .whitespaces).count - 1
    }

    static func syllables(_ text: String) -> [String] {
        fatalError()
    }

    static func syllableCount(text: String) -> Int {
        words(text).map({ SyllableCounter.shared.count(word: $0) }).sum()
    }

    static func uniqueWords(text: String) -> Int {
        Set(words(text)).count
    }

    static func averageWordLength(text: String) -> Int {
        let wc = wordCount(text: text)
        guard wc > 0 else { return 0}
        return characterCount(text: text) / wc
    }

    static func readingLevel(text: String) -> FleschKincaidReadingLevel? {
        let words = Double(wordCount(text: text))
        let sentences = Double(sentenceCount(text: text))
        let syllables = Double(syllableCount(text: text))
        guard words > 0 && sentences > 0 else { return nil }
        let fles = 206.835 - (1.015 * (words / sentences)) - (84.6 * (syllables / words))
        return FleschKincaidReadingLevel(fles: fles)
    }

    static func readingTime(text: String) -> TimeInterval {
        let readingTimePerLetter = 0.05
        let totalTime = words(text).map({ Double($0.count) * readingTimePerLetter }).reduce(0, +)
        return totalTime
    }

    static func speakingTime(text: String) -> TimeInterval {
        let speakingTimePerLetter = 0.05
        let totalTime = words(text).map({ Double($0.count) * speakingTimePerLetter }).reduce(0, +)
        return totalTime
    }
}
