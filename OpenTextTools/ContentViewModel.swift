//
//  ContentViewModel.swift
//  OpenTextTools
//
//  Created by Ian Manor on 17/02/21.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var text = ""
    @Published var regex = ""
    @Published var transformedText = ""
    @Published var showTransforms = false
    @Published var transformHeight = Constants.maxTransformHeight

    func apply(_ transform: TextTransform) {
        transformedText = text.transform(transform)
        showTransforms = true
    }
}
