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

    func titleCase() -> String {
        capitalized
    }

    func sentenceCase() -> String {
        Analyzer.sentences(self).map({ $0.capitalizingFirstLetter() }).joined()
    }
}
