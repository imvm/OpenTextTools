//
//  TextTransformer.swift
//  OpenTextTools
//
//  Created by Ian Manor on 06/02/21.
//

class Transformer {
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
