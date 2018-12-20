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

    func test_init_fromInt() {
        // Given...

        let expectationMcmxcixSymbols: [RomanNumeralSymbol] = [.M, .M, .C, .C, .X, .X, .I] // 1999 for subtractive lol

        // When...

        // Long addition w/ few OOO symbols
        let mcmxcix = try! BasicNotationRomanNumeral(intValue: 2221)

        // Then...

        XCTAssert(mcmxcix.symbols == expectationMcmxcixSymbols)
    }

    func test_init_fromSymbols() {
        // Given...

        // When...

        // Basic addition
        let xxvi = try! BasicNotationRomanNumeral(symbols: [.X, .X, .V, .I])
        // Basic addition w/ single OOO symbol
        let xxiv = try! BasicNotationRomanNumeral(symbols: [.X, .X, .I, .V])

        // Long addition
        let mmdclxxxxi = try! BasicNotationRomanNumeral(symbols: [.M, .M, .D, .C, .L, .X, .X, .X, .X, .I])
        // Long addition w/ single OOO symbol
        let mmcdlxxxix = try! BasicNotationRomanNumeral(symbols: [.M, .M, .D, .C, .L, .X, .X, .X, .I, .X])

        // Then...

        XCTAssert(xxvi.intValue == 26)
        XCTAssert(xxiv.intValue == 26)

        XCTAssert(mmdclxxxxi.intValue == 2691)
        XCTAssert(mmcdlxxxix.intValue == 2691)
    }

}

// MARK: - Initialization Performance Tests

extension BasicNotationRomanNumeralTests {

    // MARK: Tests

    func test_perf_initializeEntireNumericalSpace_fromInt() {
        measure {
            for i in BasicNotationRomanNumeral.minimumIntValue...BasicNotationRomanNumeral.maximumIntValue {
                _ = try! BasicNotationRomanNumeral(intValue: i)
            }
        }
    }

    func test_perf_initializeEntireNumericalSpace_fromSymbols() {
        let minimumValue = BasicNotationRomanNumeral.minimumIntValue
        let maximumValue = BasicNotationRomanNumeral.maximumIntValue
        let allSymbolCollections = (minimumValue...maximumValue)
            .map { try! BasicNotationRomanNumeral(intValue: $0).symbols }

        measure {
            allSymbolCollections.forEach { _ = try! BasicNotationRomanNumeral(symbols: $0) }
        }
    }

}

// MARK: - Operators Tests

extension BasicNotationRomanNumeralTests {

    // MARK: Tests

    func test_add_success() {
        // Given...

        let ccclxviiii = try! BasicNotationRomanNumeral(symbols: [.C, .C, .C, .L, .X, .V, .I, .I, .I, .I]) // 369
        let dcccxxxxxv = try! BasicNotationRomanNumeral(symbols: [.D, .C, .C, .C, .X, .X, .X, .X, .V]) // 845
        let mccxiiii = try! BasicNotationRomanNumeral(symbols: [.M, .C, .C, .X, .I, .I, .I, .I]) // 1214

        // When...

        // Then...

        XCTAssertEqual(ccclxviiii + dcccxxxxxv, mccxiiii) // 369 + 845 = 1214
    }

    func test_add_overflow() {
        // Given...

        let mmmdcccclxxxxviiii = try! BasicNotationRomanNumeral(
            symbols: [.M, .M, .M, .D, .C, .C, .C, .C, .L, .X, .X, .X, .X, .V, .I, .I, .I, .I]) // 3999
        let ii = try! BasicNotationRomanNumeral(symbols: [.I, .I]) // 2

        // When...

        // Then...

        //        XCTAssertThrowsError(mmmdcccclxxxxviiii + ii) // 3999 + 2 = 4001 (invalid)
    }

    func test_add_perf_100Iterations() {
        // Given...

        let mmmdcccclxxxxviiii = try! BasicNotationRomanNumeral(symbols: [
            .M, .M, .M, .D, .C, .C, .C, .C, .L, .X, .X, .X, .X, .V, .I, .I, .I, .I
            ]) // 3999

        // When...

        // Then...

        measure {
            for _ in 1...100 {
                _ = mmmdcccclxxxxviiii + mmmdcccclxxxxviiii
            }
        }
    }

    func test_add_perf_100Iterations_intComparison() {
        // Given...

        // When...

        // Then...

        measure {
            for _ in 1...100 {
                _ = 3999 + 3999
            }
        }
    }

    func test_add_perf_10000Iterations() {
        // Given...

        let mmmdcccclxxxxviiii = try! BasicNotationRomanNumeral(
            symbols: [.M, .M, .M, .D, .C, .C, .C, .C, .L, .X, .X, .X, .X, .V, .I, .I, .I, .I]) // 3999

        // When...

        // Then...

        measure {
            for _ in 1...10000 {
                _ = mmmdcccclxxxxviiii + mmmdcccclxxxxviiii
            }
        }
    }

    func test_add_perf_10000Iterations_intComparison() {
        // Given...

        // When...

        // Then...

        measure {
            for _ in 1...10000 {
                _ = 3999 + 3999
            }
        }
    }

}
