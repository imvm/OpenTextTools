//
//  TextTransformer.swift
//  OpenTextTools
//
//  Created by Ian Manor on 06/02/21.
//

import Regex

extension String {
    func transform(_ transforms: [TextTransform]) -> String {
        var string = self

        for transform in transforms {
            string = string.transform(transform)
        }

        return string
    }

    func transform(_ transform: TextTransform) -> String {
        switch transform {
        case let .applyingCase(case: textCase):
            return self.applying(textCase: textCase)
        case let .applyingRegex(regex: regex):
            return self.applying(regex: regex).joined()
        }
    }

    func applying(textCase: TextCase) -> String {
        switch textCase {
        case .lowercase:
            return self.lowercased()
        case .uppercase:
            return self.uppercased()
        case .titleCase:
            return self.titleCase()
        case .sentenceCase:
            return self.sentenceCase()
        }
    }

    func applying(regex: String) -> [String] {
        guard let regex = try? Regex(regex) else { return [] }
        let matches = regex.matches(in: self)
        return matches.map(\.fullMatch).map(String.init)
    }

    func titleCase() -> String {
        capitalized
    }

    func sentenceCase() -> String {
        Analyzer.sentences(self).map({ $0.capitalizingFirstLetter() }).joined()
    }
}
