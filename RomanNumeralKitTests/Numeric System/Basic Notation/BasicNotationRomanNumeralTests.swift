//
//  BasicNotationRomanNumeralTests.swift
//  RomanNumeralKitTests
//
//  Created by Kyle Hughes on 4/20/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//
//  OOO = Out of Order
//  w/ = with
//

import Foundation
import XCTest

@testable import RomanNumeralKit

// swiftlint:disable force_try identifier_name

// MARK: - Initialization Tests

class BasicNotationRomanNumeralTests: XCTestCase {

    // MARK: XCTestCase Implementation

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Tests

    func test_init_symbols_success() {
        // Given...

        // When...

        // Then...

        // Long addition
        XCTAssertNoThrow(try BasicNotationRomanNumeral(symbols: [.X, .X, .V, .I]))
        // Long addition
        XCTAssertNoThrow(try BasicNotationRomanNumeral(symbols: [.M, .M, .D, .C, .L, .X, .X, .X, .X, .I]))
    }

    func test_init_symbols_outOfOrder() {
        // Given...

        // When...

        // Then...

        // Long addition w/ single OOO symbol
        XCTAssertThrowsError(try BasicNotationRomanNumeral(symbols: [.X, .X, .I, .V]))
        // Long addition w/ single OOO symbol
        XCTAssertThrowsError(try BasicNotationRomanNumeral(symbols: [.M, .M, .D, .C, .L, .X, .X, .X, .I, .X]))
    }

}

// MARK: - Operators Tests

extension BasicNotationRomanNumeralTests {

    // MARK: Tests

    func test_add_success() {
        // Given...

        let ccclxviiii: BasicNotationRomanNumeral = "CCCLXVIIII" // 369
        let dcccxxxxv: BasicNotationRomanNumeral = "DCCCXXXXV" // 845
        let mccxiiii: BasicNotationRomanNumeral = "MCCXIIII" // 1214

        // When...

        // Then...

        XCTAssertEqual(ccclxviiii + dcccxxxxv, mccxiiii) // 369 + 845 = 1214
    }

    func test_add_overflowClamp() {
        // Given...

        let maximum = BasicRomanNumeralNotation.maximum // 3999
        let i: BasicNotationRomanNumeral = "I" // 1

        // When...

        // Then...

        XCTAssertEqual(maximum + i, maximum) // 3999 + 1 = 4000 (invalid)
    }

    func test_add_perf_100Items() {
        // Given...

        let maximum = BasicRomanNumeralNotation.maximum

        // When...

        // Then...

        measure {
            for _ in 1...100 {
                _ = maximum + maximum
            }
        }
    }

    func test_subtraction_success() {
        // Given...

        let mmmdcccxxxxxv: BasicNotationRomanNumeral = "MMMDCCCXXXXV" // 3,845
        let mccclxviiii: BasicNotationRomanNumeral = "MCCCLXVIIII" // 1,369
        let mmcccclxxvi: BasicNotationRomanNumeral = "MMCCCCLXXVI" // 2,476

        // When...

        // Then...

        XCTAssertEqual(mmmdcccxxxxxv - mccclxviiii, mmcccclxxvi) // 3,845 - 1,369 = 2,476
    }

    func test_subtraction_underflowClamp() {
        // Given...

        let minimum = BasicRomanNumeralNotation.minimum // 1
        let i: BasicNotationRomanNumeral = "I" // 1

        // When...

        // Then...

        XCTAssertEqual(minimum - i, minimum) // 1 - 1 = 0 (invalid)
    }

    func test_subtraction_perf_100Items() {
        // Given...

        let maximum = BasicRomanNumeralNotation.maximum
        let mmmdcccxxxxxv: BasicNotationRomanNumeral = "MMMDCCCXXXXV" // 3,845

        // When...

        // Then...

        measure {
            for _ in 1...100 {
                _ = maximum - mmmdcccxxxxxv
            }
        }
    }

}
