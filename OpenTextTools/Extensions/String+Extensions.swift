//
//  String+Extensions.swift
//  OpenTextTools
//
//  Created by Ian Manor on 06/02/21.
//

extension String {
    init(_ scalars: [UnicodeScalar]) {
        self = .init(String.UnicodeScalarView(scalars))
    }
}
