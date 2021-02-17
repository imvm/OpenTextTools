//
//  OpenTextToolsTests.swift
//  OpenTextToolsTests
//
//  Created by Ian Manor on 14/01/21.
//

import XCTest
@testable import OpenTextTools

class OpenTextToolsTests: XCTestCase {
    var viewModel: ContentViewModel!

    override func setUpWithError() throws {
        viewModel = ContentViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testUppercaseTransform() throws {
        viewModel.text = "hello world"
        assertTextTransform(.applyingCase(case: .uppercase), "HELLO WORLD")
    }

    func testLowercaseTransform() throws {
        viewModel.text = "HELLO WORLD"
        assertTextTransform(.applyingCase(case: .lowercase), "hello world")
    }

    func assertTextTransform(_ textTransform: TextTransform, _ expectedString: String) {
        viewModel.apply(textTransform)
        XCTAssertEqual(viewModel.transformedText, expectedString)
        XCTAssertTrue(viewModel.showTransforms)
    }
}
