//
//  AdditiveRomanNumeralTests.swift
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

// swiftlint:disable force_try identifier_name

class AdditiveRomanNumeralTests: XCTestCase {
    fileprivate struct Constants {
        static let minimumNumeralIntValue = 1
        static let minimumNumeralStringValue = "I"
        static let minimumNumeralSymbols: [RomanNumeralSymbol] = [.I]
        static let minimumNumeral = AdditiveRomanNumeral.minimum

        static let middleNumeralIntValue = 1999
        static let middleNumeralStringValue = "MDCCCCLXXXXVIIII"
        static let middleNumeralSymbols: [RomanNumeralSymbol] = [.M, .D, .C, .C, .C, .C, .L, .X, .X, .X, .X, .V, .I, .I, .I, .I]
        static let middleNumeral = AdditiveRomanNumeral(unsafeSymbols: middleNumeralSymbols)

        static let maximumNumeralIntValue = 3999
        static let maximumNumeralStringValue = "MMMDCCCCLXXXXVIIII"
        static let maximumNumeralSymbols: [RomanNumeralSymbol] = [.M, .M, .M, .D, .C, .C, .C, .C, .L, .X, .X, .X, .X, .V, .I, .I, .I, .I]
        static let maximumNumeral = AdditiveRomanNumeral.maximum

        static let nonsubtractiveSymbols: [RomanNumeralSymbol] = [.M, .M, .D, .C, .L, .X, .X, .X, .X, .I]

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
}

// MARK: - AdditiveArithmetic Tests

extension AdditiveRomanNumeralTests {
    // MARK: Tests

    func test_addition_success() {
        // Given...

        let ccclxviiii: AdditiveRomanNumeral = "CCCLXVIIII" // 369
        let dcccxxxxv: AdditiveRomanNumeral = "DCCCXXXXV" // 845
        let mccxiiii: AdditiveRomanNumeral = "MCCXIIII" // 1214

        // Then...

        XCTAssertEqual(ccclxviiii + dcccxxxxv, mccxiiii) // 369 + 845 = 1214
        XCTAssertEqual(dcccxxxxv + ccclxviiii, mccxiiii) // 845 + 369 = 1214
    }

    func test_addition_inout_success() {
        // Given...

        let ccclxviiii: AdditiveRomanNumeral = "CCCLXVIIII" // 369
        let dcccxxxxv: AdditiveRomanNumeral = "DCCCXXXXV" // 845
        let mccxiiii: AdditiveRomanNumeral = "MCCXIIII" // 1214

        // When

        var lhs = ccclxviiii
        lhs += dcccxxxxv

        // Then...

        XCTAssertEqual(lhs, mccxiiii) // 369 + 845 = 1214
    }

    func test_addition_overflowClamp() {
        // Given...

        let maximum = AdditiveRomanNumeral.maximum // 3999
        let i: AdditiveRomanNumeral = "I" // 1

        // Then...

        XCTAssertEqual(maximum + i, maximum) // 3999 + 1 = 4000 (invalid)
    }

    func test_addition_underflowClamp() {
        // Given...

        let minimum = AdditiveRomanNumeral.minimum
        let nulla = AdditiveRomanNumeral(unsafeSymbols: [.nulla])

        // Then...

        XCTAssertEqual(nulla + nulla, minimum) // 0 + 0 = 0 (invalid)
    }

    func test_addition_perf_100Items() {
        measure {
            for _ in 1 ... 100 {
                _ = Constants.middleNumeral + Constants.middleNumeral
            }
        }
    }

    func test_subtraction_success() {
        // Given...

        let mmmdcccxxxxxv: AdditiveRomanNumeral = "MMMDCCCXXXXV" // 3,845
        let mccclxviiii: AdditiveRomanNumeral = "MCCCLXVIIII" // 1,369
        let mmcccclxxvi: AdditiveRomanNumeral = "MMCCCCLXXVI" // 2,476

        // Then...

        XCTAssertEqual(mmmdcccxxxxxv - mccclxviiii, mmcccclxxvi) // 3,845 - 1,369 = 2,476
    }

    func test_subtraction_inout_success() {
        // Given...

        let mmmdcccxxxxxv: AdditiveRomanNumeral = "MMMDCCCXXXXV" // 3,845
        let mccclxviiii: AdditiveRomanNumeral = "MCCCLXVIIII" // 1,369
        let mmcccclxxvi: AdditiveRomanNumeral = "MMCCCCLXXVI" // 2,476

        // When...

        var lhs = mmmdcccxxxxxv
        lhs -= mccclxviiii

        // Then...

        XCTAssertEqual(lhs, mmcccclxxvi) // 3,845 - 1,369 = 2,476
    }

    func test_subtraction_underflowClamp() {
        // Given...

        let minimum = AdditiveRomanNumeral.minimum // 1
        let i: AdditiveRomanNumeral = "I" // 1

        // Then...

        XCTAssertEqual(minimum - i, minimum) // 1 - 1 = 0 (invalid)
    }

    func test_subtraction_perf_100Items() {
        // Given...

        let maximum = AdditiveRomanNumeral.maximum
        let mmmdcccxxxxxv: AdditiveRomanNumeral = "MMMDCCCXXXXV" // 3,845

        // Then...

        measure {
            for _ in 1 ... 100 {
                _ = maximum - mmmdcccxxxxxv
            }
        }
    }
}

// MARK: - AdditiveRomanNumeralConvertible Tests

extension AdditiveRomanNumeralTests {
    func test_basicRomanNumeral() {
        XCTAssertEqual(Constants.minimumNumeral.additiveRomanNumeral, Constants.minimumNumeral)
        XCTAssertEqual(Constants.middleNumeral.additiveRomanNumeral, Constants.middleNumeral)
        XCTAssertEqual(Constants.maximumNumeral.additiveRomanNumeral, Constants.maximumNumeral)
    }
}

// MARK: - AdditiveRomanNumeralSymbolsConvertible Tests

extension AdditiveRomanNumeralTests {
    func test_basicRomanNumeralSymbols() {
        // Given...

        // When...

        // Then...

        XCTAssertEqual(Constants.minimumNumeral.additiveRomanNumeralSymbols, Constants.minimumNumeralSymbols)
        XCTAssertEqual(Constants.middleNumeral.additiveRomanNumeralSymbols, Constants.middleNumeralSymbols)
        XCTAssertEqual(Constants.maximumNumeral.additiveRomanNumeralSymbols, Constants.maximumNumeralSymbols)
    }
}

// MARK: - Numeric Tests

extension AdditiveRomanNumeralTests {
    func test_init_exactlyBinaryInteger_success() {
        XCTAssertEqual(AdditiveRomanNumeral(exactly: Constants.minimumNumeralIntValue), Constants.minimumNumeral)
        XCTAssertEqual(AdditiveRomanNumeral(exactly: Constants.middleNumeralIntValue), Constants.middleNumeral)
        XCTAssertEqual(AdditiveRomanNumeral(exactly: Constants.maximumNumeralIntValue), Constants.maximumNumeral)
    }

    func test_init_exactlyBinaryInteger_overflow() {
        XCTAssertNil(AdditiveRomanNumeral(exactly: 4000))
    }

    func test_init_exactlyBinaryInteger_underflow() {
        XCTAssertNil(AdditiveRomanNumeral(exactly: 0))
        XCTAssertNil(AdditiveRomanNumeral(exactly: -1))
    }

    func test_multiplication_success() {
        // Given...

        let i: AdditiveRomanNumeral = "I" // 1
        let xxvii: AdditiveRomanNumeral = "XXVII" // 27
        let cxiii: AdditiveRomanNumeral = "CXXIII" // 123
        let mmmcccxi: AdditiveRomanNumeral = "MMMCCCXXI" // 3,321

        // Then...

        XCTAssertEqual(xxvii * i, xxvii)
        XCTAssertEqual(i * xxvii, xxvii)
        XCTAssertEqual(cxiii * i, cxiii)
        XCTAssertEqual(i * cxiii, cxiii)
        XCTAssertEqual(xxvii * cxiii, mmmcccxi) // 27 * 123 = 3,321
        XCTAssertEqual(cxiii * xxvii, mmmcccxi) // 123 * 27 = 3,321
    }

    func test_multiplication_inout_success() {
        // Given...

        let xxvii: AdditiveRomanNumeral = "XXVII" // 27
        let cxiii: AdditiveRomanNumeral = "CXXIII" // 123
        let mmmcccxi: AdditiveRomanNumeral = "MMMCCCXXI" // 3,321

        // When...

        var lhs = xxvii
        lhs *= cxiii

        // Then...

        XCTAssertEqual(lhs, mmmcccxi) // 27 * 123 = 3,321
    }

    func test_multiplication_overflowClamp() {
        // Given...

        let xxvii: AdditiveRomanNumeral = "XXVII" // 27
        let m: AdditiveRomanNumeral = "M" // 1,000

        // Then...

        XCTAssertEqual(xxvii * m, Constants.maximumNumeral) // 27 * 1,000 = 27,000
        XCTAssertEqual(m * xxvii, Constants.maximumNumeral) // 1000 * 27 = 27,000
    }

    func test_multiplication_perf_100items() {
        // Given...

        let xxxviiii: AdditiveRomanNumeral = "XXXVIIII" // 39
        let lxxxxviiii: AdditiveRomanNumeral = "LXXXXVIIII" // 99

        // Then...

        measure {
            for _ in 1 ... 100 {
                _ = xxxviiii * lxxxxviiii
            }
        }
    }

    func test_magnitude() {
        XCTAssertEqual(Constants.minimumNumeral.magnitude, UInt16(Constants.minimumNumeralIntValue))
        XCTAssertEqual(Constants.middleNumeral.magnitude, UInt16(Constants.middleNumeralIntValue))
        XCTAssertEqual(Constants.maximumNumeral.magnitude, UInt16(Constants.maximumNumeralIntValue))
    }
}

// MARK: - RomanNumeralProtocol Tests

extension AdditiveRomanNumeralTests {
    func test_init_symbols_success() {
        XCTAssertNoThrow(try AdditiveRomanNumeral(symbols: Constants.minimumNumeralSymbols))
        XCTAssertNoThrow(try AdditiveRomanNumeral(symbols: Constants.middleNumeralSymbols))
        XCTAssertNoThrow(try AdditiveRomanNumeral(symbols: Constants.maximumNumeralSymbols))
    }

    func test_init_symbols_condense_success() {
        // Given...

        let redundantSymbols: [RomanNumeralSymbol] = [.D, .D, .C, .C, .C, .C, .C, .C, .C, .C, .C, .C, .C, .L, .L, .L, .X, .X, .X, .X, .V, .V, .V, .V, .I, .I]
        let condensedSymbols: [RomanNumeralSymbol] = [.M, .M, .C, .C, .C, .X, .I, .I]

        // Then...

        XCTAssertNoThrow(try AdditiveRomanNumeral(symbols: redundantSymbols))
        XCTAssertEqual(
            try? AdditiveRomanNumeral(symbols: redundantSymbols),
            try? AdditiveRomanNumeral(symbols: condensedSymbols)
        )
    }

    func test_init_symbols_outOfOrder() {
        // Given...

        let singleOutOfOrderSymbol: [RomanNumeralSymbol] = [.X, .X, .I, .V]
        let multipleOutOfOrderSymbols: [RomanNumeralSymbol] = [.M, .M, .C, .D, .X, .L, .X, .X, .I, .X]

        // Then...

        XCTAssertThrowsError(try AdditiveRomanNumeral(symbols: singleOutOfOrderSymbol))
        XCTAssertThrowsError(try AdditiveRomanNumeral(symbols: multipleOutOfOrderSymbols))
    }

    func test_init_symbols_valueLessThanMinimum() {
        // Given...

        let noSymbols: [RomanNumeralSymbol] = []
        let lessThanMinimumSymbols: [RomanNumeralSymbol] = [.nulla]

        // Then...

        XCTAssertThrowsError(try AdditiveRomanNumeral(symbols: noSymbols)) {
            XCTAssertEqual($0 as? RomanNumeralError, RomanNumeralError.valueLessThanMinimum)
        }

        XCTAssertThrowsError(try AdditiveRomanNumeral(symbols: lessThanMinimumSymbols)) {
            XCTAssertEqual($0 as? RomanNumeralError, RomanNumeralError.valueLessThanMinimum)
        }
    }

    func test_init_symbols_valueGreaterThanMaximum() {
        // Given...

        let greaterThanMaximumSymbols: [RomanNumeralSymbol] = [.M, .M, .M, .M]

        // Then...

        XCTAssertThrowsError(try AdditiveRomanNumeral(symbols: greaterThanMaximumSymbols)) {
            XCTAssertEqual($0 as? RomanNumeralError, RomanNumeralError.valueGreaterThanMaximum)
        }
    }

    func test_condense() {
        // Given...

        let redundantSymbols: [RomanNumeralSymbol] = [.D, .D, .D, .D, .D, .D, .D, .C, .C, .C, .L, .L, .L, .X, .X, .X, .X, .I, .I, .I, .I, .I, .I, .I, .I, .I]

        // Then...

        XCTAssertEqual(AdditiveRomanNumeral.condense(symbols: redundantSymbols), Constants.maximumNumeralSymbols)
        XCTAssertEqual(
            AdditiveRomanNumeral.condense(symbols: Array(repeating: .I, count: Constants.maximumNumeralIntValue)),
            Constants.maximumNumeralSymbols
        )
    }

//    func test_symbolsFromInt() {
//        XCTAssertEqual(
//            AdditiveRomanNumeral.symbols(from: Constants.minimumNumeralIntValue),
//            Constants.minimumNumeralSymbols
//        )
//        XCTAssertEqual(
//            AdditiveRomanNumeral.symbols(from: Constants.middleNumeralIntValue),
//            Constants.middleNumeralSymbols
//        )
//        XCTAssertEqual(
//            AdditiveRomanNumeral.symbols(from: Constants.maximumNumeralIntValue),
//            Constants.maximumNumeralSymbols
//        )
//
//        for symbol in RomanNumeralSymbol.allSymbolsAscending {
//            XCTAssertEqual(RomanNumeral.symbols(from: symbol.rawValue.tallyMarks.count), [symbol])
//        }
//    }

    func test_symbols() {
        XCTAssertEqual(Constants.minimumNumeral.symbols, Constants.minimumNumeralSymbols)
        XCTAssertEqual(Constants.middleNumeral.symbols, Constants.middleNumeralSymbols)
        XCTAssertEqual(Constants.maximumNumeral.symbols, Constants.maximumNumeralSymbols)
    }
}

// MARK: - RomanNumeralProtocol Extension Tests

extension AdditiveRomanNumeralTests {
    func test_init_variadicSymbols_success() {
        XCTAssertNoThrow(try AdditiveRomanNumeral(.I))
        XCTAssertNoThrow(try AdditiveRomanNumeral(.M, .D, .C, .C, .C, .C, .L, .X, .X, .X, .X, .V, .I, .I, .I, .I))
        XCTAssertNoThrow(try AdditiveRomanNumeral(.M, .M, .M, .D, .C, .C, .C, .C, .L, .X, .X, .X, .X, .V, .I, .I, .I, .I))
    }

    func test_init_variadicSymbols_condense_success() {
        // TODO: Implement
    }

    func test_init_variadicSymbols_outOfOrder() {
        XCTAssertThrowsError(try AdditiveRomanNumeral(.M, .M, .D, .C, .L, .X, .X, .I, .M)) {
            XCTAssertEqual($0 as? RomanNumeralError, .symbolsOutOfOrder)
        }
        XCTAssertThrowsError(try AdditiveRomanNumeral(.M, .M, .L, .C, .D, .X, .X, .I, .V, .X)) {
            XCTAssertEqual($0 as? RomanNumeralError, .symbolsOutOfOrder)
        }
    }

    func test_init_variadicSymbols_valueLessThanMinimum() {
        XCTAssertThrowsError(try AdditiveRomanNumeral()) {
            XCTAssertEqual($0 as? RomanNumeralError, .valueLessThanMinimum)
        }
        XCTAssertThrowsError(try AdditiveRomanNumeral(.nulla)) {
            XCTAssertEqual($0 as? RomanNumeralError, .valueLessThanMinimum)
        }
    }

    func test_init_variadicSymbols_valueGreaterThanMaximum() {
        XCTAssertThrowsError(try AdditiveRomanNumeral(.M, .M, .M, .M)) {
            XCTAssertEqual($0 as? RomanNumeralError, .valueGreaterThanMaximum)
        }
    }

    func test_init_singleSymbol_success() {
        for symbol in RomanNumeralSymbol.allSymbolsAscending {
            XCTAssertNoThrow(try AdditiveRomanNumeral(symbol: symbol))
        }
    }

    func test_init_singleSymbol_valueLessThanMinimum() {
        XCTAssertThrowsError(try AdditiveRomanNumeral(symbol: .nulla)) {
            XCTAssertEqual($0 as? RomanNumeralError, .valueLessThanMinimum)
        }
    }

    func test_init_fromInt_success() {
        XCTAssertEqual(try AdditiveRomanNumeral(from: Constants.minimumNumeralIntValue), Constants.minimumNumeral)
        XCTAssertEqual(try AdditiveRomanNumeral(from: Constants.middleNumeralIntValue), Constants.middleNumeral)
        XCTAssertEqual(try AdditiveRomanNumeral(from: Constants.maximumNumeralIntValue), Constants.maximumNumeral)
    }

    func test_init_fromInt_valueLessThanMinimum() {
        // Given...

        let zero = 0
        let negativeInt = -5

        // Then...

        XCTAssertThrowsError(try AdditiveRomanNumeral(from: zero)) {
            XCTAssertEqual($0 as? RomanNumeralError, .valueLessThanMinimum)
        }
        XCTAssertThrowsError(try AdditiveRomanNumeral(from: negativeInt)) {
            XCTAssertEqual($0 as? RomanNumeralError, .valueLessThanMinimum)
        }
    }

    func test_init_fromInt_valueGreaterThanMaximum() {
        // Given...

        let largeInt = 4000

        // Then...

        XCTAssertThrowsError(try AdditiveRomanNumeral(from: largeInt)) {
            XCTAssertEqual($0 as? RomanNumeralError, .valueGreaterThanMaximum)
        }
    }

    func test_init_fromString_success() {
        XCTAssertNoThrow(try AdditiveRomanNumeral(from: Constants.minimumNumeralStringValue))
        XCTAssertNoThrow(try AdditiveRomanNumeral(from: Constants.middleNumeralStringValue))
        XCTAssertNoThrow(try AdditiveRomanNumeral(from: Constants.maximumNumeralStringValue))
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

        XCTAssertThrowsError(try AdditiveRomanNumeral(from: outOfOrderNonsubtractiveSymbols)) {
            XCTAssertEqual($0 as? RomanNumeralError, .symbolsOutOfOrder)
        }
        XCTAssertThrowsError(try AdditiveRomanNumeral(from: outOfOrderSubtractiveSymbols)) {
            XCTAssertEqual($0 as? RomanNumeralError, .symbolsOutOfOrder)
        }
    }

    func test_init_fromString_valueLessThanMinimum() {
        // Given...

        let emptyString = ""

        // Then...

        XCTAssertThrowsError(try AdditiveRomanNumeral(from: emptyString)) {
            XCTAssertEqual($0 as? RomanNumeralError, .valueLessThanMinimum)
        }
    }

    func test_init_fromString_valueGreaterThanMaximum() {
        // Given...

        let largeString = "MMMM"

        // Then...

        XCTAssertThrowsError(try AdditiveRomanNumeral(from: largeString)) {
            XCTAssertEqual($0 as? RomanNumeralError, .valueGreaterThanMaximum)
        }
    }

    func test_init_fromString_invalidCharacters() {
        // Given...

        let invalidString = "XXXR"

        // Then...

        XCTAssertThrowsError(try AdditiveRomanNumeral(from: invalidString)) {
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

    func test_stringFromSymbols() {
        XCTAssertEqual(
            AdditiveRomanNumeral.string(from: Constants.minimumNumeralSymbols),
            Constants.minimumNumeralStringValue
        )
        XCTAssertEqual(
            AdditiveRomanNumeral.string(from: Constants.middleNumeralSymbols),
            Constants.middleNumeralStringValue
        )
        XCTAssertEqual(
            AdditiveRomanNumeral.string(from: Constants.maximumNumeralSymbols),
            Constants.maximumNumeralStringValue
        )
    }

    func test_symbolsFromString_success() {
        XCTAssertNoThrow(try AdditiveRomanNumeral.symbols(from: Constants.minimumNumeralStringValue))
        XCTAssertNoThrow(try AdditiveRomanNumeral.symbols(from: Constants.middleNumeralStringValue))
        XCTAssertNoThrow(try AdditiveRomanNumeral.symbols(from: Constants.maximumNumeralStringValue))
    }

    func test_symbolsFromString_invalidCharacters() {
        // Given...

        let invalidString = "XXXR"

        // Then...

        XCTAssertThrowsError(try AdditiveRomanNumeral.symbols(from: invalidString)) {
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
        XCTAssertEqual(Constants.minimumNumeral.copyrightText, "Copyright © \(Constants.minimumNumeral.stringValue)")
        XCTAssertEqual(Constants.middleNumeral.copyrightText, "Copyright © \(Constants.middleNumeral.stringValue)")
        XCTAssertEqual(Constants.maximumNumeral.copyrightText, "Copyright © \(Constants.maximumNumeral.stringValue)")
    }

    func test_intValue() {
        XCTAssertEqual(Constants.minimumNumeral.intValue, Constants.minimumNumeralIntValue)
        XCTAssertEqual(Constants.middleNumeral.intValue, Constants.middleNumeralIntValue)
        XCTAssertEqual(Constants.maximumNumeral.intValue, Constants.maximumNumeralIntValue)
    }

    func test_stringValue() {
        XCTAssertEqual(Constants.minimumNumeral.stringValue, Constants.minimumNumeralStringValue)
        XCTAssertEqual(Constants.middleNumeral.stringValue, Constants.middleNumeralStringValue)
        XCTAssertEqual(Constants.maximumNumeral.stringValue, Constants.maximumNumeralStringValue)
    }
}

// MARK: - Comparable Tests

extension AdditiveRomanNumeralTests {
    func test_lessThan() {
        XCTAssertTrue(Constants.minimumNumeral < Constants.middleNumeral)
        XCTAssertTrue(Constants.minimumNumeral < Constants.maximumNumeral)
        XCTAssertTrue(Constants.middleNumeral < Constants.maximumNumeral)

        XCTAssertFalse(Constants.middleNumeral < Constants.minimumNumeral)
        XCTAssertFalse(Constants.maximumNumeral < Constants.minimumNumeral)
        XCTAssertFalse(Constants.maximumNumeral < Constants.middleNumeral)
    }
}

// MARK: - ExpressibleByIntegerLiteral Tests

extension AdditiveRomanNumeralTests {
    func test_init_integerLiteral_success() {
        XCTAssertEqual(1 as AdditiveRomanNumeral, Constants.minimumNumeral)
        XCTAssertEqual(1999 as AdditiveRomanNumeral, Constants.middleNumeral)
        XCTAssertEqual(3999 as AdditiveRomanNumeral, Constants.maximumNumeral)
    }

    func test_init_integerLiteral_underflowClamp() {
        XCTAssertEqual(0 as AdditiveRomanNumeral, Constants.minimumNumeral)
        XCTAssertEqual(-5 as AdditiveRomanNumeral, Constants.minimumNumeral)
    }

    func test_init_integerLiteral_overflowClamp() {
        XCTAssertEqual(4000 as AdditiveRomanNumeral, Constants.maximumNumeral)
    }
}

// MARK: - ExpressibleByStringLiteral Tests

extension AdditiveRomanNumeralTests {
    func test_init_stringLiteral_success() {
        XCTAssertEqual("I" as AdditiveRomanNumeral, Constants.minimumNumeral)
        XCTAssertEqual("MDCCCCLXXXXVIIII" as AdditiveRomanNumeral, Constants.middleNumeral)
        XCTAssertEqual("MMMDCCCCLXXXXVIIII" as AdditiveRomanNumeral, Constants.maximumNumeral)
    }

    func test_init_stringLiteral_emptyString() {
        XCTAssertEqual("" as AdditiveRomanNumeral, Constants.minimumNumeral)
    }

    func test_init_stringLiteral_overflowClamp() {
        XCTAssertEqual("MMMM" as AdditiveRomanNumeral, Constants.maximumNumeral)
    }

    func test_init_stringLiteral_invalidCharacters() {
        XCTAssertEqual("XXXR" as AdditiveRomanNumeral, Constants.minimumNumeral)
    }
}

// MARK: - Strideable Tests

extension AdditiveRomanNumeralTests {
    func test_strideable() {
        for (index, numeral) in (Constants.minimumNumeral ... Constants.maximumNumeral).enumerated() {
            XCTAssertEqual(numeral.intValue, index + 1)
        }
    }

    func test_advancedBy_overflowClamp() {
        XCTAssertEqual(Constants.maximumNumeral.advanced(by: 1), Constants.maximumNumeral)
    }

    func test_advancedBy_underflowClamp() {
        XCTAssertEqual(Constants.minimumNumeral.advanced(by: -1), Constants.minimumNumeral)
    }
}

// MARK: - RomanNumeralConvertible Tests

extension AdditiveRomanNumeralTests {
    func test_romanNumeral() {
        // Given...

        let minimumSubtractiveNumeral = RomanNumeral.minimum
        let middleSubtractiveNumeral = RomanNumeral(unsafeSymbols: [.M, .CM, .XC, .IX])
        let maximumSubtractiveNumeral = RomanNumeral.maximum

        // Then...

        XCTAssertEqual(Constants.minimumNumeral.romanNumeral, minimumSubtractiveNumeral)
        XCTAssertEqual(Constants.middleNumeral.romanNumeral, middleSubtractiveNumeral)
        XCTAssertEqual(Constants.maximumNumeral.romanNumeral, maximumSubtractiveNumeral)
    }
}

// MARK: - RomanNumeralSymbolsConvertible Tests

extension AdditiveRomanNumeralTests {
    func test_romanNumeralSymbols() {
        XCTAssertEqual(Constants.minimumNumeral.romanNumeralSymbols, [.I])
        XCTAssertEqual(Constants.middleNumeral.romanNumeralSymbols, [.M, .C, .M, .X, .C, .I, .X])
        XCTAssertEqual(Constants.maximumNumeral.romanNumeralSymbols, [.M, .M, .M, .C, .M, .X, .C, .I, .X])
    }
}

// MARK: - SubtractiveRomanNumeralSymbolsConvertible Tests

extension AdditiveRomanNumeralTests {
    func test_subtractiveRomanNumeralSymbols() {
        // Given...

        let minimumSubtractiveNumeralSymbols = RomanNumeral.minimum.subtractiveRomanNumeralSymbols
        let middleSubtractiveNumeralSymbols: [SubtractiveRomanNumeralSymbol] = [.M, .CM, .XC, .IX]
        let maximumSubtractiveNumeralSymbols = RomanNumeral.maximum.subtractiveRomanNumeralSymbols

        // Then...

        XCTAssertEqual(Constants.minimumNumeral.subtractiveRomanNumeralSymbols, minimumSubtractiveNumeralSymbols)
        XCTAssertEqual(Constants.middleNumeral.subtractiveRomanNumeralSymbols, middleSubtractiveNumeralSymbols)
        XCTAssertEqual(Constants.maximumNumeral.subtractiveRomanNumeralSymbols, maximumSubtractiveNumeralSymbols)
    }
}
