//
//  String+FormatUserInputTest.swift
//  RecipleaseTests
//
//  Created by Morgan on 21/01/2019.
//  Copyright © 2019 Morgan. All rights reserved.
//

import XCTest
@testable import Reciplease

class String_FormatUserInputTest: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // test string+formatUserInput
    func testStringFormatWithCommaAndWhiteSpaceReturnStringSetCapitalizedWithCommaAndWhiteSpace() {
        // given
        let string = """
                        word1   word2

                word3

        word4 word5

        """
        // when
        let formattedString = Set(string.format(with: ", "))

        // then
        XCTAssertEqual(formattedString, Set("Word1, Word2, Word3, Word4, Word5"))
    }
}
