//
//  TextTransform.swift
//  OpenTextTools
//
//  Created by Ian Manor on 17/02/21.
//

enum TextTransform: Hashable {
    case applyingCase(case: TextCase)
    case applyingRegex(regex: String)
}
