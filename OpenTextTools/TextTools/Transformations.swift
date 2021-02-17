//
//  TextTransformer.swift
//  OpenTextTools
//
//  Created by Ian Manor on 06/02/21.
//

enum TextCase: Hashable {
    case lowercase
    case uppercase
    case titleCase
    case sentenceCase
}

enum TextTransform: Hashable {
    case applyingCase(case: TextCase)
    case applyingRegex(regex: String)
}

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
            return self.applying(regex: regex)
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

    func applying(regex: String) -> String {
        fatalError()
    }

    func titleCase() -> String {
        self.capitalized
    }

    func sentenceCase() -> String {
        Analyzer.sentences(self).map({ $0.capitalizingFirstLetter() }).joined()
    }
}
