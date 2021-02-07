//
//  Comparable+Clamped.swift
//  OpenTextTools
//
//  Created by Ian Manor on 06/02/21.
//

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        min(max(self, limits.lowerBound), limits.upperBound)
    }
}
