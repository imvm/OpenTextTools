//
//  ContentView.swift
//  OpenTextTools
//
//  Created by Ian Manor on 14/01/21.
//

import SwiftUI
import PartitionKit

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel

    var body: some View {
        NavigationView {
            sidebar
            if viewModel.showTransforms || viewModel.showRegexMatches {
                VPart {
                    TextEditor(text: $viewModel.text)
                } bottom: {
                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            if viewModel.showRegexMatches {
                                HighlightedText(text: viewModel.text, highlightedRanges: viewModel.regexMatches)
                                    .animation(.none)
                            } else {
                                transformations
                                    .animation(.none)
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                } handle: {
                    indicator
                }
            } else {
                TextEditor(text: $viewModel.text)
            }
        }
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
            VStack {
                Text("Regex")
                    .font(.headline)
                regex
            }
            .padding()
            Spacer()
        }
    }

    var regex: some View {
        VStack {
            TextField("Regex", text: $viewModel.regex)
            Button {
                viewModel.showRegexMatches = true
            } label: {
                Text("Apply")
            }
            if viewModel.showRegexMatches {
                Button {
                    viewModel.showRegexMatches = false
                } label: {
                    Text("Hide matches")
                }
            }
        }
    }

    var transforms: some View {
        VStack(alignment: .leading) {
            Button {
                viewModel.apply(.applyingCase(case: .uppercase))
            } label: {
                Label("Uppercase", systemImage: "arrow.up")
            }
            Button {
                viewModel.apply(.applyingCase(case: .lowercase))
            } label: {
                Label("Lowercase", systemImage: "arrow.down")
            }
            Button {
                viewModel.apply(.applyingCase(case: .titleCase))
            } label: {
                Text("Title Case")
            }
            Button {
                viewModel.apply(.applyingCase(case: .sentenceCase))
            } label: {
                Text("Sentence Case")
            }
        }
    }

    var analyses: some View {
        VStack(alignment: .leading) {
            Label("Word count: \(Analyzer.wordCount(text: viewModel.text))", systemImage: "number.circle")
            Label("Avg word length: \(Analyzer.averageWordLength(text: viewModel.text))", systemImage: "number.circle")
            Label("Character count: \(Analyzer.characterCount(text: viewModel.text))", systemImage: "number.circle")
            Label("Syllable count: \(Analyzer.syllableCount(text: viewModel.text))", systemImage: "number.circle")
            Label("Sentence count: \(Analyzer.sentenceCount(text: viewModel.text))", systemImage: "number.circle")
            Label("Unique words: \(Analyzer.uniqueWords(text: viewModel.text))", systemImage: "number.circle")
            if let readingLevel = Analyzer.readingLevel(text: viewModel.text) {
                Label("Reading level: \(readingLevel.description)", systemImage: "book.circle")
            }
            Label("Reading time: \(viewModel.formattedReadingTime) seconds", systemImage: "deskclock")
            Label("Speaking time: \(viewModel.formattedSpeakingTime) seconds", systemImage: "deskclock")
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
            if viewModel.showTransforms {
                ScrollView {
                    HStack {
                        Text(viewModel.transformedText)
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
        ContentView(viewModel: ContentViewModel())
    }
}
