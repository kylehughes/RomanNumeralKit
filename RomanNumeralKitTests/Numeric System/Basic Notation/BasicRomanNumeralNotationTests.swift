//
//  BasicRomanNumeralNotationTests.swift
//  RomanNumeralKitTests
//
//  Created by Kyle Hughes on 1/29/19.
//  Copyright © 2019 Kyle Hughes. All rights reserved.
//

import XCTest

@testable import RomanNumeralKit

class BasicRomanNumeralNotationTests: XCTestCase {

    // MARK: XCTestCase Implementation

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Tests

    func test_condenseSymbolOfCount_success() {
        // TODO: Simplify this with a helper function based on the pattern

        // We want to test each symbol for:
        // (A) Identity
        // (B) Crossover to next highest symbol
        // (C) Each value that the symbol plays a subtractive role in a subtractive notation value

        // I (A)
        XCTAssertEqual(BasicRomanNumeralNotation.condense(symbol: .I, ofCount: 1), [.I])
        // I (B)
        XCTAssertEqual(BasicRomanNumeralNotation.condense(symbol: .I, ofCount: 5), [.V])
        // I (C)
        XCTAssertEqual(BasicRomanNumeralNotation.condense(symbol: .I, ofCount: 4), [.I, .I, .I, .I])
        XCTAssertEqual(BasicRomanNumeralNotation.condense(symbol: .I, ofCount: 9), [.V, .I, .I, .I, .I])

        // V (A)
        XCTAssertEqual(BasicRomanNumeralNotation.condense(symbol: .V, ofCount: 1), [.V])
        // V (B)
        XCTAssertEqual(BasicRomanNumeralNotation.condense(symbol: .V, ofCount: 2), [.X])

        // X (A)
        XCTAssertEqual(BasicRomanNumeralNotation.condense(symbol: .X, ofCount: 1), [.X])
        // X (B)
        XCTAssertEqual(BasicRomanNumeralNotation.condense(symbol: .X, ofCount: 5), [.L])
        // X (C)
        XCTAssertEqual(BasicRomanNumeralNotation.condense(symbol: .X, ofCount: 4), [.X, .X, .X, .X])
        XCTAssertEqual(BasicRomanNumeralNotation.condense(symbol: .X, ofCount: 9), [.L, .X, .X, .X, .X])

        // L (A)
        XCTAssertEqual(BasicRomanNumeralNotation.condense(symbol: .L, ofCount: 1), [.L])
        // L (B)
        XCTAssertEqual(BasicRomanNumeralNotation.condense(symbol: .L, ofCount: 2), [.C])

        // C (A)
        XCTAssertEqual(BasicRomanNumeralNotation.condense(symbol: .C, ofCount: 1), [.C])
        // C (B)
        XCTAssertEqual(BasicRomanNumeralNotation.condense(symbol: .C, ofCount: 5), [.D])
        // C (C)
        XCTAssertEqual(BasicRomanNumeralNotation.condense(symbol: .C, ofCount: 4), [.C, .C, .C, .C])
        XCTAssertEqual(BasicRomanNumeralNotation.condense(symbol: .C, ofCount: 9), [.D, .C, .C, .C, .C])

        // D (A)
        XCTAssertEqual(BasicRomanNumeralNotation.condense(symbol: .D, ofCount: 1), [.D])
        // D (B)
        XCTAssertEqual(BasicRomanNumeralNotation.condense(symbol: .D, ofCount: 2), [.M])

        // M (A)
        XCTAssertEqual(BasicRomanNumeralNotation.condense(symbol: .M, ofCount: 1), [.M])
        // M (B)
//        XCTAssertThrowsError(BasicRomanNumeralNotation.condense(symbol: .M, ofCount: 5))
//        // M (C)
//        XCTAssertThrowsError(BasicRomanNumeralNotation.condense(symbol: .M, ofCount: 4))
//        XCTAssertThrowsError(BasicRomanNumeralNotation.condense(symbol: .M, ofCount: 9))
    }

}
