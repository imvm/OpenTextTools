//
//  ContentView.swift
//  OpenTextTools
//
//  Created by Ian Manor on 14/01/21.
//

import SwiftUI

enum FleschKincaidReadingLevel: CustomStringConvertible {
    case veryEasy
    case easy
    case fairlyEasy
    case medium
    case fairlyHard
    case hard
    case veryHard
    case extremelyHard

    init(fles: Double) {
        switch fles {
        case 90...:
            self = .veryEasy
        case 80..<90:
            self = .easy
        case 70..<80:
            self = .fairlyEasy
        case 60..<70:
            self = .medium
        case 50..<60:
            self = .fairlyHard
        case 30..<50:
            self = .hard
        case 10..<30:
            self = .veryHard
        case ...10:
            self = .extremelyHard
        default:
            fatalError()
        }
    }

    var description: String {
        switch self {
            case .veryEasy:
                return "Very Easy"
            case .easy:
                return "Easy"
            case .fairlyEasy:
                return "Fairly Easy"
            case .medium:
                return "Medium"
            case .fairlyHard:
                return "Fairly Hard"
            case .hard:
                return "Hard"
            case .veryHard:
                return "Very Hard"
            case .extremelyHard:
                return "Extremely Hard"
        }
    }
}

extension String {
    init(_ scalars: [UnicodeScalar]) {
        self = .init(String.UnicodeScalarView(scalars))
    }
}

class TextAnalyzer {
    static func characterCount(text: String) -> Int {
        let scalars = text.unicodeScalars.compactMap { scalar in
            CharacterSet.whitespacesAndNewlines.contains(scalar) ? nil : scalar
        }

        return String(scalars).count
    }

    private static func words(_ text: String) -> [String] {
        text.components(separatedBy: .whitespacesAndNewlines).compactMap({ $0.isEmpty ? nil : $0 })
    }

    static func wordCount(text: String) -> Int {
        words(text).count
    }

    static func sentenceCount(text: String) -> Int {
        text.components(separatedBy: .whitespaces).count - 1
    }

    static func paragraphCount(text: String) -> Int {
        text.components(separatedBy: .whitespaces).count - 1
    }

    static func syllableCount(text: String) -> Int {
        text.components(separatedBy: .whitespaces).count - 1
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
        let timePerLetter = 0.05
        let totalTime = words(text).map({ Double($0.count) * timePerLetter }).reduce(0, +)
        return totalTime
    }

    static func speakingTime(text: String) -> TimeInterval {
        fatalError()
    }
}

class TextTransformer {
    static func lowercase(text: String) -> String {
        text.lowercased()
    }

    static func uppercase(text: String) -> String {
        text.uppercased()
    }

    static func titleCase(text: String) -> String {
        fatalError()
    }

    static func sentenceCase(text: String) -> String {
        fatalError()
    }

    static func applying(regex: String) -> String {
        fatalError()
    }
}

struct ContentView: View {
    @State var text = ""
    @State var showTransforms = false

    var body: some View {
        HStack(alignment: .top) {
            stats
            TextEditor(text: $text)
        }
    }

    var stats: some View {
        VStack(alignment: .leading) {
            if !text.isEmpty {
                transformButton
                transformations
                    .animation(.easeInOut)
                    .frame(height: showTransforms ? 200 : 0)
            }
            analyses
        }
        .padding()
    }

    var transformButton: some View {
        Button {
            showTransforms.toggle()
        } label: {
            HStack {
                Text(showTransforms ? "Hide transformed" : "Show transformed")
                Image(systemName: showTransforms ? "arrow.down" : "arrow.up")
            }
        }
    }

    var formattedReadingTime: String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: TextAnalyzer.readingTime(text: text)))!
    }

    var analyses: some View {
        VStack(alignment: .leading) {
            Label("Word count: \(TextAnalyzer.wordCount(text: text))", systemImage: "number.circle")
            Label("Avg word length: \(TextAnalyzer.averageWordLength(text: text))", systemImage: "number.circle")
            Label("Character count: \(TextAnalyzer.characterCount(text: text))", systemImage: "number.circle")
            Label("Unique words: \(TextAnalyzer.uniqueWords(text: text))", systemImage: "number.circle")
            if let readingLevel = TextAnalyzer.readingLevel(text: text) {
                Label("Reading level: \(readingLevel.description)", systemImage: "book.circle")
            }
            Label("Reading time: \(formattedReadingTime) seconds", systemImage: "deskclock")
        }
    }

    @ViewBuilder
    var transformations: some View {
        if showTransforms {
            Text(text)
        } else {
            EmptyView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
