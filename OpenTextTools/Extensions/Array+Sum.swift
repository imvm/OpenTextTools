//
//  Array+Sum.swift
//  OpenTextTools
//
//  Created by Ian Manor on 17/02/21.
//

extension Array where Element: AdditiveArithmetic {
    func sum() -> Element {
        reduce(.zero, +)
    }
}
