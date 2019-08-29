//
//  CalendarTests+RomanNumeral.swift
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

class CalendarTestsPlusRomanNumeral: XCTestCase {
    // MARK: XCTestCase Implementation

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Tests

    func test_currentYearAsRomanNumeral() {
        // Given...

        let currentYear = Calendar.current.component(.year, from: Date())
        let expectedRomanNumeral = try? RomanNumeral(from: currentYear)

        // When...

        let actualRomanNumeral = Calendar.current.currentYearAsRomanNumeral

        // Then...

        XCTAssertNotNil(actualRomanNumeral)
        XCTAssertEqual(actualRomanNumeral, expectedRomanNumeral)
    }

    func test_yearAsRomanNumeral() {
        // Given...

        let date = Date(timeIntervalSince1970: 712_800_001) // 1992-08-03

        let expectedRomanNumeral = MCMXCII

        // When...

        let actualRomanNumeral = Calendar.current.yearAsRomanNumeral(fromDate: date)

        // Then...

        XCTAssertEqual(actualRomanNumeral, expectedRomanNumeral)
    }
}
