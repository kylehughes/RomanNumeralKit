//
//  RomanNumeralSymbolTests.swift
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

class RomanNumeralSymbolTests: XCTestCase {
    // MARK: XCTestCase Implementation

    override func setUp() {}

    override func tearDown() {}

    // MARK: Tests

    func test_multiplication() {
        XCTAssertEqual(RomanNumeralSymbol.nulla * .nulla, [])

        for lhs in RomanNumeralSymbol.allSymbolsAscending {
            XCTAssertEqual(lhs * .nulla, [])
        }

        for lhs in RomanNumeralSymbol.allSymbolsAscending {
            for rhs in RomanNumeralSymbol.allSymbolsAscending {
                let expectedProduct = lhs.rawValue.tallyMarks.count * rhs.rawValue.tallyMarks.count
                let actualProduct = (lhs * rhs).map { $0.rawValue.tallyMarks.count }.reduce(0, +)
                XCTAssertEqual(actualProduct, expectedProduct)
            }
        }
    }

    func test_expandedIntoLesserSymbol() {
        XCTAssertEqual(RomanNumeralSymbol.nulla.expandedIntoLesserSymbol, [])
        XCTAssertEqual(RomanNumeralSymbol.I.expandedIntoLesserSymbol, [.I])
        XCTAssertEqual(RomanNumeralSymbol.V.expandedIntoLesserSymbol, [.I, .I, .I, .I, .I])
        XCTAssertEqual(RomanNumeralSymbol.X.expandedIntoLesserSymbol, [.V, .V])
        XCTAssertEqual(RomanNumeralSymbol.L.expandedIntoLesserSymbol, [.X, .X, .X, .X, .X])
        XCTAssertEqual(RomanNumeralSymbol.C.expandedIntoLesserSymbol, [.L, .L])
        XCTAssertEqual(RomanNumeralSymbol.D.expandedIntoLesserSymbol, [.C, .C, .C, .C, .C])
        XCTAssertEqual(RomanNumeralSymbol.M.expandedIntoLesserSymbol, [.D, .D])
    }
}

// MARK: - AdditiveRomanNumeralConvertible Tests

extension RomanNumeralSymbolTests {
    func test_additiveRomanNumeral() {
        for symbol in RomanNumeralSymbol.allSymbolsAscending {
            XCTAssertEqual(symbol.additiveRomanNumeral, try AdditiveRomanNumeral(symbol: symbol))
        }
    }
}

// MARK: - AdditiveRomanNumeralSymbolConvertible Tests

extension RomanNumeralSymbolTests {
    func test_basicRomanNumeralSymbolConvertible() {
        for symbol in RomanNumeralSymbol.allSymbolsAscending {
            XCTAssertEqual(symbol.additiveRomanNumeralSymbol, symbol)
        }
    }
}

// MARK: - AdditiveRomanNumeralSymbolsConvertible Tests

extension RomanNumeralSymbolTests {
    func test_basicRomanNumeralSymbolsConvertible() {
        for symbol in RomanNumeralSymbol.allSymbolsAscending {
            XCTAssertEqual(symbol.additiveRomanNumeralSymbols, [symbol])
        }
    }
}

// MARK: - Comparable Tests

extension RomanNumeralSymbolTests {
    func test_lessThan() {
        XCTAssert(RomanNumeralSymbol.I < RomanNumeralSymbol.V)
        XCTAssert(RomanNumeralSymbol.V < RomanNumeralSymbol.X)
        XCTAssert(RomanNumeralSymbol.X < RomanNumeralSymbol.L)
        XCTAssert(RomanNumeralSymbol.L < RomanNumeralSymbol.C)
        XCTAssert(RomanNumeralSymbol.C < RomanNumeralSymbol.D)
        XCTAssert(RomanNumeralSymbol.D < RomanNumeralSymbol.M)

        XCTAssertFalse(RomanNumeralSymbol.V < RomanNumeralSymbol.I)
        XCTAssertFalse(RomanNumeralSymbol.X < RomanNumeralSymbol.V)
        XCTAssertFalse(RomanNumeralSymbol.L < RomanNumeralSymbol.X)
        XCTAssertFalse(RomanNumeralSymbol.C < RomanNumeralSymbol.L)
        XCTAssertFalse(RomanNumeralSymbol.D < RomanNumeralSymbol.C)
        XCTAssertFalse(RomanNumeralSymbol.M < RomanNumeralSymbol.D)

        XCTAssertFalse(RomanNumeralSymbol.I < RomanNumeralSymbol.I)
        XCTAssertFalse(RomanNumeralSymbol.V < RomanNumeralSymbol.V)
        XCTAssertFalse(RomanNumeralSymbol.X < RomanNumeralSymbol.X)
        XCTAssertFalse(RomanNumeralSymbol.L < RomanNumeralSymbol.L)
        XCTAssertFalse(RomanNumeralSymbol.C < RomanNumeralSymbol.C)
        XCTAssertFalse(RomanNumeralSymbol.D < RomanNumeralSymbol.D)
        XCTAssertFalse(RomanNumeralSymbol.M < RomanNumeralSymbol.M)
    }
}

// MARK: - CustomDebugStringConvertible Tests

extension RomanNumeralSymbolTests {
    func test_debugDescription() {
        for symbol in RomanNumeralSymbol.allCases {
            XCTAssertEqual(symbol.debugDescription, symbol.stringValue)
        }
    }
}

// MARK: - CustomStringConvertible Tests

extension RomanNumeralSymbolTests {
    func test_description() {
        for symbol in RomanNumeralSymbol.allCases {
            XCTAssertEqual(symbol.description, symbol.stringValue)
        }
    }
}

// MARK: - RawRepresentable Tests

extension RomanNumeralSymbolTests {
    func test_init_rawValue_success() {
        XCTAssertEqual(RomanNumeralSymbol(rawValue: .nulla), .nulla)
        XCTAssertEqual(RomanNumeralSymbol(rawValue: .one), .I)
        XCTAssertEqual(RomanNumeralSymbol(rawValue: .five), .V)
        XCTAssertEqual(RomanNumeralSymbol(rawValue: .ten), .X)
        XCTAssertEqual(RomanNumeralSymbol(rawValue: .fifty), .L)
        XCTAssertEqual(RomanNumeralSymbol(rawValue: .oneHundred), .C)
        XCTAssertEqual(RomanNumeralSymbol(rawValue: .fiveHundred), .D)
        XCTAssertEqual(RomanNumeralSymbol(rawValue: .oneThousand), .M)
    }

    func test_init_rawValue_invalid() {
        // Given...

        let two = RomanNumeralTallyMarkGroup(numberOfTallyMarks: 2)
        let eleven = RomanNumeralTallyMarkGroup(numberOfTallyMarks: 11)
        let oneHundredOne = RomanNumeralTallyMarkGroup(numberOfTallyMarks: 101)
        let oneThousandOne = RomanNumeralTallyMarkGroup(numberOfTallyMarks: 1001)

        // Then...

        XCTAssertNil(RomanNumeralSymbol(rawValue: two))
        XCTAssertNil(RomanNumeralSymbol(rawValue: eleven))
        XCTAssertNil(RomanNumeralSymbol(rawValue: oneHundredOne))
        XCTAssertNil(RomanNumeralSymbol(rawValue: oneThousandOne))
    }
}

// MARK: - RomanNumeralSymbolProtocol Tests

extension RomanNumeralSymbolTests {
    func test_init_fromString_success() {
        XCTAssertEqual(try RomanNumeralSymbol(from: "N"), .nulla)
        XCTAssertEqual(try RomanNumeralSymbol(from: "I"), .I)
        XCTAssertEqual(try RomanNumeralSymbol(from: "V"), .V)
        XCTAssertEqual(try RomanNumeralSymbol(from: "X"), .X)
        XCTAssertEqual(try RomanNumeralSymbol(from: "L"), .L)
        XCTAssertEqual(try RomanNumeralSymbol(from: "C"), .C)
        XCTAssertEqual(try RomanNumeralSymbol(from: "D"), .D)
        XCTAssertEqual(try RomanNumeralSymbol(from: "M"), .M)
    }

    func test_init_fromString_invalidCharacter() {
        XCTAssertThrowsError(try RomanNumeralSymbol(from: "R")) {
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

    func test_allSymbolsAscending() {
        XCTAssertEqual(RomanNumeralSymbol.allSymbolsAscending, [.I, .V, .X, .L, .C, .D, .M])
    }

    func test_allSymbolsDescending() {
        XCTAssertEqual(RomanNumeralSymbol.allSymbolsDescending, [.M, .D, .C, .L, .X, .V, .I])
    }

    func test_stringValue() {
        XCTAssertEqual(RomanNumeralSymbol.nulla.stringValue, "N")
        XCTAssertEqual(RomanNumeralSymbol.I.stringValue, "I")
        XCTAssertEqual(RomanNumeralSymbol.V.stringValue, "V")
        XCTAssertEqual(RomanNumeralSymbol.X.stringValue, "X")
        XCTAssertEqual(RomanNumeralSymbol.L.stringValue, "L")
        XCTAssertEqual(RomanNumeralSymbol.C.stringValue, "C")
        XCTAssertEqual(RomanNumeralSymbol.D.stringValue, "D")
        XCTAssertEqual(RomanNumeralSymbol.M.stringValue, "M")
    }

    func test_lesserSymbol() {
        XCTAssertEqual(RomanNumeralSymbol.nulla.lesserSymbol, nil)
        XCTAssertEqual(RomanNumeralSymbol.I.lesserSymbol, nil)
        XCTAssertEqual(RomanNumeralSymbol.V.lesserSymbol, .I)
        XCTAssertEqual(RomanNumeralSymbol.X.lesserSymbol, .V)
        XCTAssertEqual(RomanNumeralSymbol.L.lesserSymbol, .X)
        XCTAssertEqual(RomanNumeralSymbol.C.lesserSymbol, .L)
        XCTAssertEqual(RomanNumeralSymbol.D.lesserSymbol, .C)
        XCTAssertEqual(RomanNumeralSymbol.M.lesserSymbol, .D)
    }
}

// MARK: - RomanNumeralSymbolConvertible Tests

extension RomanNumeralSymbolTests {
    func test_romanNumeralSymbol() {
        for symbol in RomanNumeralSymbol.allSymbolsAscending {
            XCTAssertEqual(symbol.romanNumeralSymbol, symbol)
        }
    }
}

// MARK: - RomanNumeralSymbolsConvertible Tests

extension RomanNumeralSymbolTests {
    func test_romanNumeralSymbols() {
        for symbol in RomanNumeralSymbol.allSymbolsAscending {
            XCTAssertEqual(symbol.romanNumeralSymbols, [symbol])
        }
    }
}

// MARK: - SubtractiveRomanNumeralSymbolsConvertible Tests

extension RomanNumeralSymbolTests {
    func test_subtractiveRomanNumeralSymbols() {
        for symbol in RomanNumeralSymbol.allSymbolsAscending {
            let expectedSubtractiveSymbols = IntToSubtractiveRomanNumeralSymbolsConversionAlgorithm.convert(
                from: symbol.rawValue.tallyMarks.count
            )
            XCTAssertEqual(symbol.subtractiveRomanNumeralSymbols, expectedSubtractiveSymbols)
        }
    }
}
