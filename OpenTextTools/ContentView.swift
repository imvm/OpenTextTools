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

    static func wordCount(text: String) -> Int {
        text.components(separatedBy: .whitespacesAndNewlines).compactMap({ $0.isEmpty ? nil : $0 }).count
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
    @State var showTransforms = false

    var body: some View {
        VStack {
            TextEditor(text: $text)
            HStack {
                VStack(alignment: .leading) {
                    if !text.isEmpty {
                        Button {
                            showTransforms.toggle()
                        } label: {
                            HStack {
                                Text(showTransforms ? "Hide transformed" : "Show transformed")
                                Image(systemName: showTransforms ? "arrow.down" : "arrow.up")
                            }
                        }
                        transformations
                            .animation(.easeInOut)
                            .frame(height: showTransforms ? 200 : 0)
                    }
                    analyses
                }
                .padding()
                Spacer()
            }
        }
    }

    var analyses: some View {
        VStack(alignment: .leading) {
            Text("Word count: \(TextAnalyzer.wordCount(text: text))")
            Text("Character count: \(TextAnalyzer.characterCount(text: text))")
            Text("Reading level: \(TextAnalyzer.readingLevel(text: text).rawValue)")
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
