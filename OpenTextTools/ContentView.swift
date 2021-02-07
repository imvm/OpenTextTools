//
//  ContentView.swift
//  OpenTextTools
//
//  Created by Ian Manor on 14/01/21.
//

import SwiftUI

extension String {
    init(_ scalars: [UnicodeScalar]) {
        self = .init(String.UnicodeScalarView(scalars))
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
