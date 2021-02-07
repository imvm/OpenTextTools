//
//  ContentView.swift
//  OpenTextTools
//
//  Created by Ian Manor on 14/01/21.
//

import SwiftUI
import PartitionKit

struct Constants {
    static let maxTransformHeight: CGFloat = 200
}

struct ContentView: View {
    @State var text = ""
    @State var transformedText = ""
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
            if showTransforms {
                VPart {
                    TextEditor(text: $text)
                } bottom: {
                    transformations
                } handle: {
                    indicator
                }
            } else {
                TextEditor(text: $text)
            }
        }
    }

    func apply(_ transform: TextTransform) {
        transformedText = text.transform(transform)
        showTransforms = true
    }

    var sidebar: some View {
        VStack(alignment: .leading) {
            VStack {
                Text("Analyses")
                    .font(.headline)
                analyses
            }
            .padding()
            VStack {
                Text("Transforms")
                    .font(.headline)
                transforms
            }
            .padding()
        }
    }

    var transforms: some View {
        VStack(alignment: .leading) {
            Button {
                apply(.applyingCase(case: .uppercase))
            } label: {
                Label("Uppercase", systemImage: "arrow.up")
            }
            Button {
                apply(.applyingCase(case: .lowercase))
            } label: {
                Label("Lowercase", systemImage: "arrow.down")
            }
            Button {
                apply(.applyingCase(case: .titleCase))
            } label: {
                Text("Title Case")
            }
            Button {
                apply(.applyingCase(case: .sentenceCase))
            } label: {
                Text("Sentence Case")
            }
            Spacer()
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
        HStack {
            Circle()
                .frame(width: 5, height: 5)
            Circle()
                .frame(width: 5, height: 5)
            Circle()
                .frame(width: 5, height: 5)
        }
        .foregroundColor(.primary)
        .contentShape(Rectangle())
    }

    @ViewBuilder
    var transformations: some View {
        VStack {
            if showTransforms {
                ScrollView {
                    HStack {
                        Text(transformedText)
                            .multilineTextAlignment(.leading)
                            .animation(.none)
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
