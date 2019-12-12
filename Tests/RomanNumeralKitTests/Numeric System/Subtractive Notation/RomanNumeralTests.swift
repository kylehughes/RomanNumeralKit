//
//  RomanNumeralTests.swift
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

class RomanNumeralTests: XCTestCase {
    fileprivate struct Constants {
        static let minimumNumeralIntValue = 1
        static let minimumNumeralStringValue = "I"
        static let minimumNumeralValueEquivalentAdditiveSymbols: [RomanNumeralSymbol] = [.I]
        static let minimumNumeralSymbolEquivalentAdditiveSymbols: [RomanNumeralSymbol] = [.I]
        static let minimumNumeralSubtractiveSymbols: [SubtractiveRomanNumeralSymbol] = [.I]
        static let minimumBasicNumeral = AdditiveRomanNumeral.minimum
        static let minimumSubtractiveNumeral = RomanNumeral.minimum

        static let middleNumeralIntValue = 1999
        static let middleNumeralStringValue = "MCMXCIX"
        static let middleNumeralValueEquivalentAdditiveSymbols: [RomanNumeralSymbol] = [.M, .D, .C, .C, .C, .C, .L, .X, .X, .X, .X, .V, .I, .I, .I, .I]
        static let middleNumeralSymbolEquivalentAdditiveSymbols: [RomanNumeralSymbol] = [.M, .C, .M, .X, .C, .I, .X]
        static let middleNumeralSubtractiveSymbols: [SubtractiveRomanNumeralSymbol] = [.M, .CM, .XC, .IX]
        static let middleBasicNumeral = AdditiveRomanNumeral(unsafeSymbols: middleNumeralValueEquivalentAdditiveSymbols)
        static let middleSubtractiveNumeral = RomanNumeral(unsafeSymbols: middleNumeralSubtractiveSymbols)

        static let maximumNumeralIntValue = 3999
        static let maximumNumeralStringValue = "MMMCMXCIX"
        static let maximumNumeralValueEquivalentAdditiveSymbols: [RomanNumeralSymbol] = [.M, .M, .M, .D, .C, .C, .C, .C, .L, .X, .X, .X, .X, .V, .I, .I, .I, .I]
        static let maximumNumeralSymbolEquivalentAdditiveSymbols: [RomanNumeralSymbol] = [.M, .M, .M, .C, .M, .X, .C, .I, .X]
        static let maximumNumeralSubtractiveSymbols: [SubtractiveRomanNumeralSymbol] = [.M, .M, .M, .CM, .XC, .IX]
        static let maximumBasicNumeral = AdditiveRomanNumeral.maximum
        static let maximumSubtractiveNumeral = RomanNumeral.maximum

        static let nonsubtractiveAdditiveSymbols: [RomanNumeralSymbol] = [.M, .M, .D, .C, .L, .X, .X, .X, .X, .I]
        static let subtractiveAdditiveSymbols: [RomanNumeralSymbol] = [.M, .M, .C, .D, .L, .X, .X, .X, .I, .V]

        // MARK: Initialization

        private init() {}
    }

    // MARK: XCTestCase Implementation

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Tests

    func test_init_symbols_success() {
        XCTAssertNoThrow(try RomanNumeral(subtractiveSymbols: Constants.minimumNumeralSubtractiveSymbols))
        XCTAssertNoThrow(try RomanNumeral(subtractiveSymbols: Constants.middleNumeralSubtractiveSymbols))
        XCTAssertNoThrow(try RomanNumeral(subtractiveSymbols: Constants.maximumNumeralSubtractiveSymbols))
    }

    func test_init_symbols_condense_success() {
        // Given...

        let redundantMiddleSymbols: [SubtractiveRomanNumeralSymbol] = [.D, .D, .CD, .CD, .C, .L, .XL, .IX]
        let redundantMaximumSymbols: [SubtractiveRomanNumeralSymbol] = [.M, .CM, .D, .D, .D, .D, .L, .X, .X, .X, .X, .V, .IV]

        // Then...

        XCTAssertEqual(
            try? RomanNumeral(subtractiveSymbols: redundantMiddleSymbols),
            Constants.middleSubtractiveNumeral
        )
        XCTAssertEqual(
            try? RomanNumeral(subtractiveSymbols: redundantMaximumSymbols),
            Constants.maximumSubtractiveNumeral
        )
    }

    func test_init_symbols_outOfOrder() {
        // Given...

        let outOfOrderNonsubtractiveSymbols: [SubtractiveRomanNumeralSymbol] = [.M, .M, .D, .C, .L, .X, .X, .I, .X]
        let outOfOrderSubtractiveSymbols: [SubtractiveRomanNumeralSymbol] = [.M, .M, .L, .CD, .X, .X, .IV, .X]

        // Then...

        XCTAssertThrowsError(try RomanNumeral(subtractiveSymbols: outOfOrderNonsubtractiveSymbols)) {
            XCTAssertEqual($0 as? RomanNumeralError, .symbolsOutOfOrder)
        }
        XCTAssertThrowsError(try RomanNumeral(subtractiveSymbols: outOfOrderSubtractiveSymbols)) {
            XCTAssertEqual($0 as? RomanNumeralError, .symbolsOutOfOrder)
        }
    }

    func test_init_symbols_valueLessThanMinimum() {
        // Given...

        let noSymbols: [SubtractiveRomanNumeralSymbol] = []
        let lessThanMinimumSymbols: [SubtractiveRomanNumeralSymbol] = [.nulla]

        // Then...

        XCTAssertThrowsError(try RomanNumeral(subtractiveSymbols: noSymbols)) {
            XCTAssertEqual($0 as? RomanNumeralError, .valueLessThanMinimum)
        }
        XCTAssertThrowsError(try RomanNumeral(subtractiveSymbols: lessThanMinimumSymbols)) {
            XCTAssertEqual($0 as? RomanNumeralError, .valueLessThanMinimum)
        }
    }

    func test_init_symbols_valueGreaterThanMaximum() {
        // Given...

        let greaterThanMaximumSymbols: [SubtractiveRomanNumeralSymbol] = [.M, .M, .M, .M]

        // Then...

        XCTAssertThrowsError(try RomanNumeral(subtractiveSymbols: greaterThanMaximumSymbols)) {
            XCTAssertEqual($0 as? RomanNumeralError, .valueGreaterThanMaximum)
        }
    }

    func test_condense() {
        // Given...

        let redundantSymbols: [SubtractiveRomanNumeralSymbol] = [.M, .D, .D, .D, .D, .CD, .CD, .C, .XL, .XL, .X, .I, .I, .I, .I, .I, .I, .I, .I, .I]

        // Then...

        XCTAssertEqual(
            RomanNumeral.condense(subtractiveSymbols: redundantSymbols),
            Constants.maximumNumeralSubtractiveSymbols
        )
        XCTAssertEqual(
            RomanNumeral.condense(subtractiveSymbols: Array(repeating: .I, count: Constants.maximumNumeralIntValue)),
            Constants.maximumNumeralSubtractiveSymbols
        )
    }

    func test_intFromSymbols() {
        XCTAssertEqual(
            RomanNumeral.int(from: Constants.minimumNumeralSubtractiveSymbols),
            Constants.minimumNumeralIntValue
        )
        XCTAssertEqual(
            RomanNumeral.int(from: Constants.middleNumeralSubtractiveSymbols),
            Constants.middleNumeralIntValue
        )
        XCTAssertEqual(
            RomanNumeral.int(from: Constants.maximumNumeralSubtractiveSymbols),
            Constants.maximumNumeralIntValue
        )

        for symbol in SubtractiveRomanNumeralSymbol.allSymbolsAscending {
            XCTAssertEqual(RomanNumeral.int(from: [symbol]), symbol.rawValue.tallyMarks.count)
        }
    }

    func test_symbolsFromInt() {
        XCTAssertEqual(
            RomanNumeral.subtractiveSymbols(from: Constants.minimumNumeralIntValue),
            Constants.minimumNumeralSubtractiveSymbols
        )
        XCTAssertEqual(
            RomanNumeral.subtractiveSymbols(from: Constants.middleNumeralIntValue),
            Constants.middleNumeralSubtractiveSymbols
        )
        XCTAssertEqual(
            RomanNumeral.subtractiveSymbols(from: Constants.maximumNumeralIntValue),
            Constants.maximumNumeralSubtractiveSymbols
        )

        for subtractiveSymbol in SubtractiveRomanNumeralSymbol.allSymbolsAscending {
            XCTAssertEqual(
                RomanNumeral.subtractiveSymbols(from: subtractiveSymbol.rawValue.tallyMarks.count),
                [subtractiveSymbol]
            )
        }
    }
}

// MARK: - AdditiveArithmetic Tests

extension RomanNumeralTests {
    // MARK: Tests

    func test_addition_success() {
        // Given...

        let ccclxix: RomanNumeral = "CCCLXIX" // 369
        let dcccxlv: RomanNumeral = "DCCCXLV" // 845
        let mccxiv: RomanNumeral = "MCCXIV" // 1214

        // Then...

        XCTAssertEqual(ccclxix + dcccxlv, mccxiv) // 369 + 845 = 1214
    }

    func test_addition_inout_success() {
        // Given...

        let ccclxix: RomanNumeral = "CCCLXIX" // 369
        let dcccxlv: RomanNumeral = "DCCCXLV" // 845
        let mccxiv: RomanNumeral = "MCCXIV" // 1214

        // When...

        var lhs = ccclxix
        lhs += dcccxlv

        // Then...

        XCTAssertEqual(lhs, mccxiv) // 369 + 845 = 1214
    }

    func test_addition_overflowClamp() {
        // Given...

        let i: RomanNumeral = "I" // 1

        // Then...

        XCTAssertEqual(Constants.maximumSubtractiveNumeral + i, Constants.maximumSubtractiveNumeral) // 3999 + 1 = 4000 (invalid)
    }

    func test_addition_underflowClamp() {
        // Given...

        let nulla = RomanNumeral(unsafeSymbols: [.nulla]) // 0

        // When...

        // Then...

        XCTAssertEqual(nulla + nulla, Constants.minimumSubtractiveNumeral) // 0 + 0 = 0 (invalid)
    }

    func test_addition_perf_100Items() {
        measure {
            for _ in 1 ... 100 {
                _ = Constants.middleSubtractiveNumeral + Constants.middleSubtractiveNumeral
            }
        }
    }

    func test_addition_perf_100Items_comparison() {
        measure {
            for _ in 1 ... 100 {
                _ = Constants.middleNumeralIntValue + Constants.middleNumeralIntValue
            }
        }
    }

    func test_subtraction_success() {
        // Given...

        let mmmdcccxlv: RomanNumeral = "MMMDCCCXLV" // 3,845
        let mccclxix: RomanNumeral = "MCCCLXIX" // 1,369
        let mmcdlxxvi: RomanNumeral = "MMCDLXXVI" // 2,476

        // Then...

        XCTAssertEqual(mmmdcccxlv - mccclxix, mmcdlxxvi) // 3,845 - 1,369 = 2,476
    }

    func test_subtraction_inout_success() {
        // Given...

        let mmmdcccxlv: RomanNumeral = "MMMDCCCXLV" // 3,845
        let mccclxix: RomanNumeral = "MCCCLXIX" // 1,369
        let mmcdlxxvi: RomanNumeral = "MMCDLXXVI" // 2,476

        // When...

        var lhs = mmmdcccxlv
        lhs -= mccclxix

        // Then...

        XCTAssertEqual(lhs, mmcdlxxvi) // 3,845 - 1,369 = 2,476
    }

    func test_subtraction_underflowClamp() {
        // Given...

        let i: RomanNumeral = "I" // 1

        // Then...

        XCTAssertEqual(Constants.minimumSubtractiveNumeral - i, Constants.minimumSubtractiveNumeral) // 1 - 1 = 0 (invalid)
    }

    func test_subtraction_perf_100Items() {
        measure {
            for _ in 1 ... 100 {
                _ = Constants.maximumSubtractiveNumeral - MMMDCCCXLV
            }
        }
    }

    func test_subtraction_perf_100Items_comparison() {
        measure {
            for _ in 1 ... 100 {
                _ = Constants.maximumNumeralIntValue - 3845
            }
        }
    }
}

// MARK: - AdditiveRomanNumeralConvertible Tests

extension RomanNumeralTests {
    func test_additiveRomanNumeral() {
        XCTAssertEqual(Constants.minimumSubtractiveNumeral.additiveRomanNumeral, Constants.minimumBasicNumeral)
        XCTAssertEqual(Constants.middleSubtractiveNumeral.additiveRomanNumeral, Constants.middleBasicNumeral)
        XCTAssertEqual(Constants.maximumSubtractiveNumeral.additiveRomanNumeral, Constants.maximumBasicNumeral)
    }
}

// MARK: - Comparable Tests

extension RomanNumeralTests {
    func test_lessThan() {
        XCTAssertTrue(Constants.minimumSubtractiveNumeral < Constants.middleSubtractiveNumeral)
        XCTAssertTrue(Constants.minimumSubtractiveNumeral < Constants.maximumSubtractiveNumeral)
        XCTAssertTrue(Constants.middleSubtractiveNumeral < Constants.maximumSubtractiveNumeral)

        XCTAssertFalse(Constants.middleSubtractiveNumeral < Constants.minimumSubtractiveNumeral)
        XCTAssertFalse(Constants.maximumSubtractiveNumeral < Constants.minimumSubtractiveNumeral)
        XCTAssertFalse(Constants.maximumSubtractiveNumeral < Constants.middleSubtractiveNumeral)
    }
}

// MARK: - ExpressibleByIntegerLiteral Tests

extension RomanNumeralTests {
    func test_init_integerLiteral_success() {
        XCTAssertEqual(1 as RomanNumeral, Constants.minimumSubtractiveNumeral)
        XCTAssertEqual(1999 as RomanNumeral, Constants.middleSubtractiveNumeral)
        XCTAssertEqual(3999 as RomanNumeral, Constants.maximumSubtractiveNumeral)
    }

    func test_init_integerLiteral_underflowClamp() {
        XCTAssertEqual(0 as RomanNumeral, Constants.minimumSubtractiveNumeral)
        XCTAssertEqual(-5 as RomanNumeral, Constants.minimumSubtractiveNumeral)
    }

    func test_init_integerLiteral_overflowClamp() {
        XCTAssertEqual(4000 as RomanNumeral, Constants.maximumSubtractiveNumeral)
    }
}

// MARK: - ExpressibleByStringLiteral Tests

extension RomanNumeralTests {
    func test_init_stringLiteral_success() {
        XCTAssertEqual("I" as RomanNumeral, Constants.minimumSubtractiveNumeral)
        XCTAssertEqual("MCMXCIX" as RomanNumeral, Constants.middleSubtractiveNumeral)
        XCTAssertEqual("MMMCMXCIX" as RomanNumeral, Constants.maximumSubtractiveNumeral)
    }

    func test_init_stringLiteral_emptyString() {
        XCTAssertEqual("" as RomanNumeral, Constants.minimumSubtractiveNumeral)
    }

    func test_init_stringLiteral_overflowClamp() {
        XCTAssertEqual("MMMM" as RomanNumeral, Constants.maximumSubtractiveNumeral)
    }

    func test_init_stringLiteral_invalidCharacters() {
        XCTAssertEqual("XXXR" as RomanNumeral, Constants.minimumSubtractiveNumeral)
    }
}

// MARK: - Numeric Tests

extension RomanNumeralTests {
    func test_init_exactlyBinaryInteger_success() {
        XCTAssertEqual(
            RomanNumeral(exactly: Constants.minimumNumeralIntValue),
            Constants.minimumSubtractiveNumeral
        )
        XCTAssertEqual(
            RomanNumeral(exactly: Constants.middleNumeralIntValue),
            Constants.middleSubtractiveNumeral
        )
        XCTAssertEqual(
            RomanNumeral(exactly: Constants.maximumNumeralIntValue),
            Constants.maximumSubtractiveNumeral
        )
    }

    func test_init_exactlyBinaryInteger_overflow() {
        XCTAssertNil(RomanNumeral(exactly: 4000))
    }

    func test_init_exactlyBinaryInteger_underflow() {
        XCTAssertNil(RomanNumeral(exactly: 0))
        XCTAssertNil(RomanNumeral(exactly: -1))
    }

    func test_multiplication_success() {
        // Given...

        let i: RomanNumeral = "I" // 1
        let ix: RomanNumeral = "IX" // 9
        let cdxxix: RomanNumeral = "CDXXIX" // 429
        let mmmdccclxi: RomanNumeral = "MMMDCCCLXI" // 3,861

        // Then...

        XCTAssertEqual(ix * i, ix)
        XCTAssertEqual(i * ix, ix)
        XCTAssertEqual(cdxxix * i, cdxxix)
        XCTAssertEqual(i * cdxxix, cdxxix)
        XCTAssertEqual(ix * cdxxix, mmmdccclxi) // 9 * 429 = 3,861
        XCTAssertEqual(cdxxix * ix, mmmdccclxi) // 429 * 9 = 3,861
    }

    func test_multiplication_inout_success() {
        // Given...

        let ix: RomanNumeral = "IX" // 9
        let cdxxix: RomanNumeral = "CDXXIX" // 429
        let mmmdccclxi: RomanNumeral = "MMMDCCCLXI" // 3,861

        // When...

        var lhs = ix
        lhs *= cdxxix

        // Then...

        XCTAssertEqual(lhs, mmmdccclxi) // 9 * 429 = 3,861
    }

    func test_multiplication_overflowClamp() {
        // Given...

        let cdl: RomanNumeral = "CDL" // 450
        let mmmdcxcvi: RomanNumeral = "MMMDCXCVI" // 3,696

        // Then...

        XCTAssertEqual(cdl * mmmdcxcvi, Constants.maximumSubtractiveNumeral) // 450 * 3696 = 1,995,840
        XCTAssertEqual(mmmdcxcvi * cdl, Constants.maximumSubtractiveNumeral) // 3696 * 450 = 1,995,840
    }

    func test_multiplication_perf_100items() {
        // Given...

        let xxviiii: AdditiveRomanNumeral = "XXXVIII" // 38
        let lxxxviii: AdditiveRomanNumeral = "LXXXVIII" // 88

        // Then...

        measure {
            for _ in 1 ... 100 {
                _ = xxviiii * lxxxviii
            }
        }
    }

    func test_multiplication_perf_100Items_comparison() {
        measure {
            for _ in 1 ... 100 {
                _ = 450 * 3696
            }
        }
    }

    func test_magnitude() {
        XCTAssertEqual(Constants.minimumSubtractiveNumeral.magnitude, UInt16(Constants.minimumNumeralIntValue))
        XCTAssertEqual(Constants.middleSubtractiveNumeral.magnitude, UInt16(Constants.middleNumeralIntValue))
        XCTAssertEqual(Constants.maximumSubtractiveNumeral.magnitude, UInt16(Constants.maximumNumeralIntValue))
    }
}

// MARK: - RomanNumeralProtocol Tests

extension RomanNumeralTests {
    func test_init_variadicSymbols_success() {
        XCTAssertNoThrow(try RomanNumeral(.M, .M, .D, .C, .L, .X, .X, .X, .X, .I))
        XCTAssertNoThrow(try RomanNumeral(.M, .M, .C, .D, .L, .X, .X, .X, .I, .V))
    }

    func test_init_variadicSymbols_condense_success() {
        // TODO: Implement
    }

    func test_init_variadicSymbols_outOfOrder() {
        XCTAssertThrowsError(try RomanNumeral(.M, .M, .D, .C, .L, .X, .X, .I, .M)) {
            XCTAssertEqual($0 as? RomanNumeralError, RomanNumeralError.symbolsOutOfOrder)
        }
        XCTAssertThrowsError(try RomanNumeral(.M, .M, .L, .C, .D, .X, .X, .I, .V, .X)) {
            XCTAssertEqual($0 as? RomanNumeralError, RomanNumeralError.symbolsOutOfOrder)
        }
    }

    func test_init_variadicSymbols_valueLessThanMinimum() {
        XCTAssertThrowsError(try RomanNumeral()) {
            XCTAssertEqual($0 as? RomanNumeralError, RomanNumeralError.valueLessThanMinimum)
        }
        XCTAssertThrowsError(try RomanNumeral(.nulla)) {
            XCTAssertEqual($0 as? RomanNumeralError, RomanNumeralError.valueLessThanMinimum)
        }
    }

    func test_init_variadicSymbols_valueGreaterThanMaximum() {
        XCTAssertThrowsError(try RomanNumeral(.M, .M, .M, .M)) {
            XCTAssertEqual($0 as? RomanNumeralError, RomanNumeralError.valueGreaterThanMaximum)
        }
    }

    func test_init_singleSymbol_success() {
        for symbol in RomanNumeralSymbol.allSymbolsAscending {
            XCTAssertNoThrow(try RomanNumeral(symbol: symbol))
        }
    }

    func test_init_singleSymbol_valueLessThanMinimum() {
        XCTAssertThrowsError(try RomanNumeral(symbol: .nulla)) {
            XCTAssertEqual($0 as? RomanNumeralError, RomanNumeralError.valueLessThanMinimum)
        }
    }

    func test_init_fromInt_success() {
        XCTAssertEqual(try RomanNumeral(from: Constants.minimumNumeralIntValue), Constants.minimumSubtractiveNumeral)
        XCTAssertEqual(try RomanNumeral(from: Constants.middleNumeralIntValue), Constants.middleSubtractiveNumeral)
        XCTAssertEqual(try RomanNumeral(from: Constants.maximumNumeralIntValue), Constants.maximumSubtractiveNumeral)
    }

    func test_init_fromInt_valueLessThanMinimum() {
        // Given...

        let zero = 0
        let negativeInt = -5

        // Then...

        XCTAssertThrowsError(try RomanNumeral(from: zero)) {
            XCTAssertEqual($0 as? RomanNumeralError, .valueLessThanMinimum)
        }
        XCTAssertThrowsError(try RomanNumeral(from: negativeInt)) {
            XCTAssertEqual($0 as? RomanNumeralError, .valueLessThanMinimum)
        }
    }

    func test_init_fromInt_valueGreaterThanMaximum() {
        // Given...

        let largeInt = 4000

        // Then...

        XCTAssertThrowsError(try RomanNumeral(from: largeInt)) {
            XCTAssertEqual($0 as? RomanNumeralError, .valueGreaterThanMaximum)
        }
    }

    func test_init_fromString_success() {
        XCTAssertNoThrow(try RomanNumeral(from: Constants.minimumNumeralStringValue))
        XCTAssertNoThrow(try RomanNumeral(from: Constants.middleNumeralStringValue))
        XCTAssertNoThrow(try RomanNumeral(from: Constants.maximumNumeralStringValue))
    }

    func test_init_fromString_condense_success() {
        // Given...

        // When...

        // Then...

        // TODO: Implement
    }

    func test_init_fromString_outOfOrder() {
        // Given...

        let outOfOrderNonsubtractiveSymbols = "MMDCLXXXIM"
        let outOfOrderSubtractiveSymbols = "MMLCDXXIVX"

        // Then...

        XCTAssertThrowsError(try RomanNumeral(from: outOfOrderNonsubtractiveSymbols)) {
            XCTAssertEqual($0 as? RomanNumeralError, .symbolsOutOfOrder)
        }
        XCTAssertThrowsError(try RomanNumeral(from: outOfOrderSubtractiveSymbols)) {
            XCTAssertEqual($0 as? RomanNumeralError, .symbolsOutOfOrder)
        }
    }

    func test_init_fromString_valueLessThanMinimum() {
        // Given...

        let emptyString = ""

        // Then...

        XCTAssertThrowsError(try RomanNumeral(from: emptyString)) {
            XCTAssertEqual($0 as? RomanNumeralError, .valueLessThanMinimum)
        }
    }

    func test_init_fromString_valueGreaterThanMaximum() {
        // Given...

        let largeString = "MMMM"

        // Then...

        XCTAssertThrowsError(try RomanNumeral(from: largeString)) {
            XCTAssertEqual($0 as? RomanNumeralError, .valueGreaterThanMaximum)
        }
    }

    func test_init_fromString_invalidCharacters() {
        // Given...

        let invalidString = "XXXR"

        // Then...

        XCTAssertThrowsError(try RomanNumeral(from: invalidString)) {
            switch $0 as? RomanNumeralSymbolError {
            case .none:
                XCTFail()
            case let .some(symbolError):
                switch symbolError {
                case .unrecognizedString:
                    break
                }
            }
        }
    }

    func test_protocol_init_symbols_success() {
        XCTAssertNoThrow(try RomanNumeral(symbols: Constants.minimumNumeralSymbolEquivalentAdditiveSymbols))
        XCTAssertNoThrow(try RomanNumeral(symbols: Constants.middleNumeralSymbolEquivalentAdditiveSymbols))
        XCTAssertNoThrow(try RomanNumeral(symbols: Constants.maximumNumeralSymbolEquivalentAdditiveSymbols))
    }

    func test_protocol_init_symbols_condense_success() {
        // TODO: Implement
    }

    func test_protocol_init_symbols_outOfOrder() {
        // Given...

        let outOfOrderNonsubtractiveSymbols: [RomanNumeralSymbol] = [.M, .M, .D, .C, .L, .X, .X, .I, .M]
        let outOfOrderSubtractiveSymbols: [RomanNumeralSymbol] = [.M, .M, .L, .C, .D, .X, .X, .I, .V, .X]

        // Then...

        XCTAssertThrowsError(try RomanNumeral(symbols: outOfOrderNonsubtractiveSymbols)) {
            XCTAssertEqual($0 as? RomanNumeralError, RomanNumeralError.symbolsOutOfOrder)
        }

        XCTAssertThrowsError(try RomanNumeral(symbols: outOfOrderSubtractiveSymbols)) {
            XCTAssertEqual($0 as? RomanNumeralError, RomanNumeralError.symbolsOutOfOrder)
        }
    }

    func test_protocol_init_symbols_valueLessThanMinimum() {
        // Given...

        let noSymbols: [RomanNumeralSymbol] = []
        let lessThanMinimumSymbols: [RomanNumeralSymbol] = [.nulla]

        // Then...

        XCTAssertThrowsError(try RomanNumeral(symbols: noSymbols)) {
            XCTAssertEqual($0 as? RomanNumeralError, RomanNumeralError.valueLessThanMinimum)
        }

        XCTAssertThrowsError(try RomanNumeral(symbols: lessThanMinimumSymbols)) {
            XCTAssertEqual($0 as? RomanNumeralError, RomanNumeralError.valueLessThanMinimum)
        }
    }

    func test_protocol_init_symbols_valueGreaterThanMaximum() {
        // Given...

        let greaterThanMaximumSymbols: [RomanNumeralSymbol] = [.M, .M, .M, .M]

        // Then...

        XCTAssertThrowsError(try RomanNumeral(symbols: greaterThanMaximumSymbols)) {
            XCTAssertEqual($0 as? RomanNumeralError, RomanNumeralError.valueGreaterThanMaximum)
        }
    }

    func test_protocol_condense() {
        // Given...

        let redundantSymbols: [RomanNumeralSymbol] = [.M, .D, .D, .D, .D, .C, .D, .C, .D, .C, .X, .L, .X, .L, .X, .I, .I, .I, .I, .I, .I, .I, .I, .I]

        // Then...

        XCTAssertEqual(
            RomanNumeral.condense(symbols: redundantSymbols),
            Constants.maximumNumeralSymbolEquivalentAdditiveSymbols
        )
        XCTAssertEqual(
            RomanNumeral.condense(symbols: Array(repeating: .I, count: Constants.maximumNumeralIntValue)),
            Constants.maximumNumeralSymbolEquivalentAdditiveSymbols
        )
    }

    func test_protocol_symbolsFromInt() {
        XCTAssertEqual(
            RomanNumeral.symbols(from: Constants.minimumNumeralIntValue),
            Constants.minimumNumeralSymbolEquivalentAdditiveSymbols
        )
        XCTAssertEqual(
            RomanNumeral.symbols(from: Constants.middleNumeralIntValue),
            Constants.middleNumeralSymbolEquivalentAdditiveSymbols
        )
        XCTAssertEqual(
            RomanNumeral.symbols(from: Constants.maximumNumeralIntValue),
            Constants.maximumNumeralSymbolEquivalentAdditiveSymbols
        )

        for symbol in RomanNumeralSymbol.allSymbolsAscending {
            XCTAssertEqual(RomanNumeral.symbols(from: symbol.rawValue.tallyMarks.count), [symbol])
        }
    }

    func test_symbols() {
        XCTAssertEqual(Constants.minimumSubtractiveNumeral.symbols, Constants.minimumNumeralSymbolEquivalentAdditiveSymbols)
        XCTAssertEqual(Constants.middleSubtractiveNumeral.symbols, Constants.middleNumeralSymbolEquivalentAdditiveSymbols)
        XCTAssertEqual(Constants.maximumSubtractiveNumeral.symbols, Constants.maximumNumeralSymbolEquivalentAdditiveSymbols)
    }

    func test_stringFromSymbols() {
        XCTAssertEqual(
            RomanNumeral.string(from: Constants.minimumNumeralSymbolEquivalentAdditiveSymbols),
            Constants.minimumNumeralStringValue
        )
        XCTAssertEqual(
            RomanNumeral.string(from: Constants.middleNumeralSymbolEquivalentAdditiveSymbols),
            Constants.middleNumeralStringValue
        )
        XCTAssertEqual(
            RomanNumeral.string(from: Constants.maximumNumeralSymbolEquivalentAdditiveSymbols),
            Constants.maximumNumeralStringValue
        )
    }

    func test_symbolsFromString_success() {
        XCTAssertNoThrow(try RomanNumeral.symbols(from: Constants.minimumNumeralStringValue))
        XCTAssertNoThrow(try RomanNumeral.symbols(from: Constants.middleNumeralStringValue))
        XCTAssertNoThrow(try RomanNumeral.symbols(from: Constants.maximumNumeralStringValue))
    }

    func test_symbolsFromString_invalidCharacters() {
        // Given...

        let invalidString = "XXXR"

        // Then...

        XCTAssertThrowsError(try RomanNumeral.symbols(from: invalidString)) {
            switch $0 as? RomanNumeralSymbolError {
            case .none:
                XCTFail()
            case let .some(symbolError):
                switch symbolError {
                case .unrecognizedString:
                    break
                }
            }
        }
    }

    func test_copyrightText() {
        XCTAssertEqual(Constants.minimumSubtractiveNumeral.copyrightText, "Copyright © \(Constants.minimumSubtractiveNumeral.stringValue)")
        XCTAssertEqual(Constants.middleSubtractiveNumeral.copyrightText, "Copyright © \(Constants.middleSubtractiveNumeral.stringValue)")
        XCTAssertEqual(Constants.maximumSubtractiveNumeral.copyrightText, "Copyright © \(Constants.maximumSubtractiveNumeral.stringValue)")
    }

    func test_intValue() {
        XCTAssertEqual(Constants.minimumSubtractiveNumeral.intValue, Constants.minimumNumeralIntValue)
        XCTAssertEqual(Constants.middleSubtractiveNumeral.intValue, Constants.middleNumeralIntValue)
        XCTAssertEqual(Constants.maximumSubtractiveNumeral.intValue, Constants.maximumNumeralIntValue)
    }

    func test_stringValue() {
        XCTAssertEqual(Constants.minimumSubtractiveNumeral.stringValue, Constants.minimumNumeralStringValue)
        XCTAssertEqual(Constants.middleSubtractiveNumeral.stringValue, Constants.middleNumeralStringValue)
        XCTAssertEqual(Constants.maximumSubtractiveNumeral.stringValue, Constants.maximumNumeralStringValue)
    }
}

// MARK: - Strideable Tests

extension RomanNumeralTests {
    func test_strideable() {
        for (index, numeral) in (Constants.minimumSubtractiveNumeral ... Constants.maximumSubtractiveNumeral).enumerated() {
            XCTAssertEqual(numeral.intValue, index + 1)
        }
    }

    func test_advancedBy_overflowClamp() {
        XCTAssertEqual(Constants.maximumSubtractiveNumeral.advanced(by: 1), Constants.maximumSubtractiveNumeral)
    }

    func test_advancedBy_underflowClamp() {
        XCTAssertEqual(Constants.minimumSubtractiveNumeral.advanced(by: -1), Constants.minimumSubtractiveNumeral)
    }
}

// MARK: - RomanNumeralConvertible Tests

extension RomanNumeralTests {
    func test_romanNumeral() {
        XCTAssertEqual(Constants.minimumSubtractiveNumeral.romanNumeral, Constants.minimumSubtractiveNumeral)
        XCTAssertEqual(Constants.middleSubtractiveNumeral.romanNumeral, Constants.middleSubtractiveNumeral)
        XCTAssertEqual(Constants.maximumSubtractiveNumeral.romanNumeral, Constants.maximumSubtractiveNumeral)
    }
}

// MARK: - RomanNumeralSymbolsConvertible Tests

extension RomanNumeralTests {
    func test_romanNumeralSymbols() {
        XCTAssertEqual(Constants.minimumSubtractiveNumeral.romanNumeralSymbols, [.I])
        XCTAssertEqual(Constants.middleSubtractiveNumeral.romanNumeralSymbols, [.M, .C, .M, .X, .C, .I, .X])
        XCTAssertEqual(Constants.maximumSubtractiveNumeral.romanNumeralSymbols, [.M, .M, .M, .C, .M, .X, .C, .I, .X])
    }
}

// MARK: - SubtractiveRomanNumeralSymbolsConvertible Tests

extension RomanNumeralTests {
    func test_subtractiveRomanNumeralSymbols() {
        // Given...

        let minimumSubtractiveNumeralSymbols = RomanNumeral.minimum.subtractiveRomanNumeralSymbols
        let middleSubtractiveNumeralSymbols: [SubtractiveRomanNumeralSymbol] = [.M, .CM, .XC, .IX]
        let maximumSubtractiveNumeralSymbols = RomanNumeral.maximum.subtractiveRomanNumeralSymbols

        // Then...

        XCTAssertEqual(
            Constants.minimumSubtractiveNumeral.subtractiveRomanNumeralSymbols,
            minimumSubtractiveNumeralSymbols
        )
        XCTAssertEqual(
            Constants.middleSubtractiveNumeral.subtractiveRomanNumeralSymbols,
            middleSubtractiveNumeralSymbols
        )
        XCTAssertEqual(
            Constants.maximumSubtractiveNumeral.subtractiveRomanNumeralSymbols,
            maximumSubtractiveNumeralSymbols
        )
    }
}
