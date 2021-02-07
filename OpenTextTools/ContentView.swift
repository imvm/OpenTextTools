//
//  ContentView.swift
//  OpenTextTools
//
//  Created by Ian Manor on 14/01/21.
//

import SwiftUI

struct Constants {
    static let maxTransformHeight: CGFloat = 200
}

struct ContentView: View {
    @State var text = ""
    @State var showTransforms = false
    @State var transformHeight = Constants.maxTransformHeight
    let timeFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        return formatter
    }()

    var body: some View {
        NavigationView {
            sidebar
            VStack {
                TextEditor(text: $text)
                if showTransforms {
                    transformations
                        .animation(.easeInOut)
                        .frame(height: showTransforms ? transformHeight : 0)
                }
            }
        }
    }

    var sidebar: some View {
        VStack(alignment: .leading) {
            analyses
            if !text.isEmpty {
                transformButton
            }
            Spacer()
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
        timeFormatter.string(from: NSNumber(value: Analyzer.readingTime(text: text)))!
    }

    var formattedSpeakingTime: String {
        timeFormatter.string(from: NSNumber(value: Analyzer.speakingTime(text: text)))!
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
            Label("Speaking time: \(formattedSpeakingTime) seconds", systemImage: "deskclock")
        }
    }

    var indicator: some View {
        ZStack {
            Rectangle()
                .frame(height: 15)
            HStack {
                Spacer()
                Circle()
                    .frame(width: 5, height: 5)
                Circle()
                    .frame(width: 5, height: 5)
                Circle()
                    .frame(width: 5, height: 5)
                Spacer()
            }
            .foregroundColor(Color(.systemGray))
        }
    }

    @ViewBuilder
    var transformations: some View {
        VStack {
            indicator
                .foregroundColor(Color(.systemGray))
            if showTransforms {
                ScrollView {
                    HStack {
                        Text(text)
                        Spacer()
                    }
                }
            } else {
                EmptyView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
