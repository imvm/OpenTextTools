//
//  ContentView.swift
//  OpenTextTools
//
//  Created by Ian Manor on 14/01/21.
//

import SwiftUI

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
        return formatter.string(from: NSNumber(value: Analyzer.readingTime(text: text)))!
    }

    var analyses: some View {
        VStack(alignment: .leading) {
            Label("Word count: \(Analyzer.wordCount(text: text))", systemImage: "number.circle")
            Label("Avg word length: \(Analyzer.averageWordLength(text: text))", systemImage: "number.circle")
            Label("Character count: \(Analyzer.characterCount(text: text))", systemImage: "number.circle")
            Label("Unique words: \(Analyzer.uniqueWords(text: text))", systemImage: "number.circle")
            if let readingLevel = Analyzer.readingLevel(text: text) {
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
