//
//  HighlightedText.swift
//  OpenTextTools
//
//  Created by Ian Manor on 18/02/21.
//

import SwiftUI

struct HighlightedText: View {
    let text: String
    let highlightedRanges: [Range<String.Index>]

    var body: some View {
        text.indices.reduce(Text("")) { result, index in
            result + Text(String(text[index])).foregroundColor(highlightedRanges.allSatisfy({ !$0.contains(index) }) ? .blue : .red)
        }
    }
}
