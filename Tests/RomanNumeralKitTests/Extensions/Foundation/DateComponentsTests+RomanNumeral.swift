//
//  DateComponentsTests+RomanNumeral.swift
//  RomanNumeralKitTests
//
//  Copyright © 2019 Kyle Hughes.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import XCTest

@testable import RomanNumeralKit

class DateComponentsTestsPlusRomanNumeral: XCTestCase {
    // MARK: XCTestCase Implementation

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Tests

    func test_yearAsRomanNumeral_success() {
        // Given...

        let date = Date(timeIntervalSince1970: 1_012_737_600) // 2002-02-03
        let yearDateComponents = Calendar.current.dateComponents([.year], from: date)

        let expectedRomanNumeral = MMII

        // When...

        let actualRomanNumeral = yearDateComponents.yearAsRomanNumeral

        // Then...

        XCTAssertEqual(actualRomanNumeral, expectedRomanNumeral)
    }

    func test_yearAsRomanNumeral_noYear() {
        // Given...

        let date = Date(timeIntervalSince1970: 1_012_737_600) // 2002-02-03
        let yearDateComponents = Calendar.current.dateComponents([.month], from: date)

        // Then...

        XCTAssertNil(yearDateComponents.yearAsRomanNumeral)
    }
}
