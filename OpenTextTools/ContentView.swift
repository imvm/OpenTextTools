//
//  ContentView.swift
//  OpenTextTools
//
//  Created by Ian Manor on 14/01/21.
//

import SwiftUI

enum FleschKincaidReadingLevel: String {
    case easy
    case medium
    case hard
}

class TextAnalyzer {
    static func characterCount(text: String) -> Int {
        text.count
    }

    static func wordCount(text: String) -> Int {
        text.components(separatedBy: .whitespaces).count - 1
    }

    static func sentenceCount(text: String) -> Int {
        text.components(separatedBy: .whitespaces).count - 1
    }

    static func paragraphCount(text: String) -> Int {
        text.components(separatedBy: .whitespaces).count - 1
    }

    static func syllables(text: String) -> Int {
        text.components(separatedBy: .whitespaces).count - 1
    }

    static func uniqueWords(text: String) -> Int {
        text.components(separatedBy: .whitespaces).count - 1
    }

    static func averageWordLength(text: String) -> Int {
        text.components(separatedBy: .whitespaces).count - 1
    }

    static func readingLevel(text: String) -> FleschKincaidReadingLevel {
        .easy
    }

    static func readingTime(text: String) -> TimeInterval {
        1
    }

    static func speakingTime(text: String) -> TimeInterval {
        1
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
        text.uppercased()
    }

    static func sentenceCase(text: String) -> String {
        text.uppercased()
    }
}

struct ContentView: View {
    @State var text = ""

    var body: some View {
        VStack {
            TextEditor(text: $text)
            Text(text)
            HStack {
                analyses
                transformations
            }
        }
    }

    var analyses: some View {
        VStack {
            Text("Word count: \(TextAnalyzer.wordCount(text: text))")
            Text("Character count: \(TextAnalyzer.characterCount(text: text))")
            Text("Reading level: \(TextAnalyzer.readingLevel(text: text).rawValue)")
        }
    }

    var transformations: some View {
        VStack {
            EmptyView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
