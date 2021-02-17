//
//  String+capitalizingFirstLetter.swift
//  OpenTextTools
//
//  Created by Ian Manor on 17/02/21.
//

extension String {
    func capitalizingFirstLetter() -> String {
        prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
