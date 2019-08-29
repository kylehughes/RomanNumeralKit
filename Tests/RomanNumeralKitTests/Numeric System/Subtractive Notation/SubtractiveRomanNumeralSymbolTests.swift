//
//  SubtractiveRomanNumeralSymbolTests.swift
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

class SubtractiveRomanNumeralSymbolTests: XCTestCase {
    // MARK: XCTestCase Implementation

    override func setUp() {}

    override func tearDown() {}

    // MARK: Tests

    func test_romanNumeralSymbols() {
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.nulla.romanNumeralSymbols, [.nulla])
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.I.romanNumeralSymbols, [.I])
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.IV.romanNumeralSymbols, [.I, .V])
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.V.romanNumeralSymbols, [.V])
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.IX.romanNumeralSymbols, [.I, .X])
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.X.romanNumeralSymbols, [.X])
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.XL.romanNumeralSymbols, [.X, .L])
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.L.romanNumeralSymbols, [.L])
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.XC.romanNumeralSymbols, [.X, .C])
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.C.romanNumeralSymbols, [.C])
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.CD.romanNumeralSymbols, [.C, .D])
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.D.romanNumeralSymbols, [.D])
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.CM.romanNumeralSymbols, [.C, .M])
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.M.romanNumeralSymbols, [.M])
    }
}

// MARK: - AdditiveRomanNumeralSymbolsConvertible Tests

extension SubtractiveRomanNumeralSymbolTests {
    func test_basicRomanNumeralSymbols() {
        for symbol in SubtractiveRomanNumeralSymbol.allSymbolsAscending {
            let expectedBasicRomanNumeralSymbols = AdditiveRomanNumeral.symbols(from: symbol.rawValue.tallyMarks.count)
            XCTAssertEqual(symbol.additiveRomanNumeralSymbols, expectedBasicRomanNumeralSymbols)
        }
    }
}

// MARK: - Comparable Tests

extension SubtractiveRomanNumeralSymbolTests {
    func test_lessThan() {
        XCTAssert(SubtractiveRomanNumeralSymbol.I < SubtractiveRomanNumeralSymbol.IV)
        XCTAssert(SubtractiveRomanNumeralSymbol.IV < SubtractiveRomanNumeralSymbol.V)
        XCTAssert(SubtractiveRomanNumeralSymbol.V < SubtractiveRomanNumeralSymbol.IX)
        XCTAssert(SubtractiveRomanNumeralSymbol.IX < SubtractiveRomanNumeralSymbol.X)
        XCTAssert(SubtractiveRomanNumeralSymbol.X < SubtractiveRomanNumeralSymbol.XL)
        XCTAssert(SubtractiveRomanNumeralSymbol.XL < SubtractiveRomanNumeralSymbol.L)
        XCTAssert(SubtractiveRomanNumeralSymbol.L < SubtractiveRomanNumeralSymbol.XC)
        XCTAssert(SubtractiveRomanNumeralSymbol.XC < SubtractiveRomanNumeralSymbol.C)
        XCTAssert(SubtractiveRomanNumeralSymbol.C < SubtractiveRomanNumeralSymbol.CD)
        XCTAssert(SubtractiveRomanNumeralSymbol.CD < SubtractiveRomanNumeralSymbol.D)
        XCTAssert(SubtractiveRomanNumeralSymbol.D < SubtractiveRomanNumeralSymbol.CM)
        XCTAssert(SubtractiveRomanNumeralSymbol.CM < SubtractiveRomanNumeralSymbol.M)

        XCTAssertFalse(SubtractiveRomanNumeralSymbol.IV < SubtractiveRomanNumeralSymbol.I)
        XCTAssertFalse(SubtractiveRomanNumeralSymbol.V < SubtractiveRomanNumeralSymbol.IV)
        XCTAssertFalse(SubtractiveRomanNumeralSymbol.IX < SubtractiveRomanNumeralSymbol.V)
        XCTAssertFalse(SubtractiveRomanNumeralSymbol.X < SubtractiveRomanNumeralSymbol.IX)
        XCTAssertFalse(SubtractiveRomanNumeralSymbol.XL < SubtractiveRomanNumeralSymbol.X)
        XCTAssertFalse(SubtractiveRomanNumeralSymbol.L < SubtractiveRomanNumeralSymbol.XL)
        XCTAssertFalse(SubtractiveRomanNumeralSymbol.XC < SubtractiveRomanNumeralSymbol.L)
        XCTAssertFalse(SubtractiveRomanNumeralSymbol.C < SubtractiveRomanNumeralSymbol.XC)
        XCTAssertFalse(SubtractiveRomanNumeralSymbol.CD < SubtractiveRomanNumeralSymbol.C)
        XCTAssertFalse(SubtractiveRomanNumeralSymbol.D < SubtractiveRomanNumeralSymbol.CD)
        XCTAssertFalse(SubtractiveRomanNumeralSymbol.CM < SubtractiveRomanNumeralSymbol.D)
        XCTAssertFalse(SubtractiveRomanNumeralSymbol.M < SubtractiveRomanNumeralSymbol.CM)

        XCTAssertFalse(SubtractiveRomanNumeralSymbol.I < SubtractiveRomanNumeralSymbol.I)
        XCTAssertFalse(SubtractiveRomanNumeralSymbol.IV < SubtractiveRomanNumeralSymbol.IV)
        XCTAssertFalse(SubtractiveRomanNumeralSymbol.V < SubtractiveRomanNumeralSymbol.V)
        XCTAssertFalse(SubtractiveRomanNumeralSymbol.IX < SubtractiveRomanNumeralSymbol.IX)
        XCTAssertFalse(SubtractiveRomanNumeralSymbol.X < SubtractiveRomanNumeralSymbol.X)
        XCTAssertFalse(SubtractiveRomanNumeralSymbol.XL < SubtractiveRomanNumeralSymbol.XL)
        XCTAssertFalse(SubtractiveRomanNumeralSymbol.L < SubtractiveRomanNumeralSymbol.L)
        XCTAssertFalse(SubtractiveRomanNumeralSymbol.XC < SubtractiveRomanNumeralSymbol.XC)
        XCTAssertFalse(SubtractiveRomanNumeralSymbol.C < SubtractiveRomanNumeralSymbol.C)
        XCTAssertFalse(SubtractiveRomanNumeralSymbol.CD < SubtractiveRomanNumeralSymbol.CD)
        XCTAssertFalse(SubtractiveRomanNumeralSymbol.D < SubtractiveRomanNumeralSymbol.D)
        XCTAssertFalse(SubtractiveRomanNumeralSymbol.CM < SubtractiveRomanNumeralSymbol.CM)
        XCTAssertFalse(SubtractiveRomanNumeralSymbol.M < SubtractiveRomanNumeralSymbol.M)
    }
}

// MARK: - CustomDebugStringConvertible Tests

extension SubtractiveRomanNumeralSymbolTests {
    func test_debugDescription() {
        for symbol in SubtractiveRomanNumeralSymbol.allCases {
            XCTAssertEqual(symbol.debugDescription, symbol.stringValue)
        }
    }
}

// MARK: - CustomStringConvertible Tests

extension SubtractiveRomanNumeralSymbolTests {
    func test_description() {
        for symbol in SubtractiveRomanNumeralSymbol.allCases {
            XCTAssertEqual(symbol.description, symbol.stringValue)
        }
    }
}

// MARK: - RawRepresentable Tests

extension SubtractiveRomanNumeralSymbolTests {
    func test_init_rawValue_success() {
        XCTAssertEqual(SubtractiveRomanNumeralSymbol(rawValue: .nulla), .nulla)
        XCTAssertEqual(SubtractiveRomanNumeralSymbol(rawValue: .one), .I)
        XCTAssertEqual(SubtractiveRomanNumeralSymbol(rawValue: .four), .IV)
        XCTAssertEqual(SubtractiveRomanNumeralSymbol(rawValue: .five), .V)
        XCTAssertEqual(SubtractiveRomanNumeralSymbol(rawValue: .nine), .IX)
        XCTAssertEqual(SubtractiveRomanNumeralSymbol(rawValue: .ten), .X)
        XCTAssertEqual(SubtractiveRomanNumeralSymbol(rawValue: .forty), .XL)
        XCTAssertEqual(SubtractiveRomanNumeralSymbol(rawValue: .fifty), .L)
        XCTAssertEqual(SubtractiveRomanNumeralSymbol(rawValue: .ninety), .XC)
        XCTAssertEqual(SubtractiveRomanNumeralSymbol(rawValue: .oneHundred), .C)
        XCTAssertEqual(SubtractiveRomanNumeralSymbol(rawValue: .fourHundred), .CD)
        XCTAssertEqual(SubtractiveRomanNumeralSymbol(rawValue: .fiveHundred), .D)
        XCTAssertEqual(SubtractiveRomanNumeralSymbol(rawValue: .nineHundred), .CM)
        XCTAssertEqual(SubtractiveRomanNumeralSymbol(rawValue: .oneThousand), .M)
    }

    func test_init_rawValue_invalid() {
        // Given...

        let two = RomanNumeralTallyMarkGroup(numberOfTallyMarks: 2)
        let eleven = RomanNumeralTallyMarkGroup(numberOfTallyMarks: 11)
        let oneHundredOne = RomanNumeralTallyMarkGroup(numberOfTallyMarks: 101)
        let oneThousandOne = RomanNumeralTallyMarkGroup(numberOfTallyMarks: 1001)

        // Then...

        XCTAssertNil(SubtractiveRomanNumeralSymbol(rawValue: two))
        XCTAssertNil(SubtractiveRomanNumeralSymbol(rawValue: eleven))
        XCTAssertNil(SubtractiveRomanNumeralSymbol(rawValue: oneHundredOne))
        XCTAssertNil(SubtractiveRomanNumeralSymbol(rawValue: oneThousandOne))
    }
}

// MARK: - RomanNumeralSymbolProtocol Tests

extension SubtractiveRomanNumeralSymbolTests {
    func test_init_fromString_success() {
        XCTAssertEqual(try SubtractiveRomanNumeralSymbol(from: "N"), .nulla)
        XCTAssertEqual(try SubtractiveRomanNumeralSymbol(from: "I"), .I)
        XCTAssertEqual(try SubtractiveRomanNumeralSymbol(from: "IV"), .IV)
        XCTAssertEqual(try SubtractiveRomanNumeralSymbol(from: "V"), .V)
        XCTAssertEqual(try SubtractiveRomanNumeralSymbol(from: "IX"), .IX)
        XCTAssertEqual(try SubtractiveRomanNumeralSymbol(from: "X"), .X)
        XCTAssertEqual(try SubtractiveRomanNumeralSymbol(from: "XL"), .XL)
        XCTAssertEqual(try SubtractiveRomanNumeralSymbol(from: "L"), .L)
        XCTAssertEqual(try SubtractiveRomanNumeralSymbol(from: "XC"), .XC)
        XCTAssertEqual(try SubtractiveRomanNumeralSymbol(from: "C"), .C)
        XCTAssertEqual(try SubtractiveRomanNumeralSymbol(from: "CD"), .CD)
        XCTAssertEqual(try SubtractiveRomanNumeralSymbol(from: "D"), .D)
        XCTAssertEqual(try SubtractiveRomanNumeralSymbol(from: "CM"), .CM)
        XCTAssertEqual(try SubtractiveRomanNumeralSymbol(from: "M"), .M)
    }

    func test_init_fromString_invalidCharacter() {
        XCTAssertThrowsError(try SubtractiveRomanNumeralSymbol(from: "R")) {
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

    func test_stringValue() {
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.nulla.stringValue, "N")
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.I.stringValue, "I")
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.IV.stringValue, "IV")
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.V.stringValue, "V")
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.IX.stringValue, "IX")
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.X.stringValue, "X")
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.XL.stringValue, "XL")
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.L.stringValue, "L")
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.XC.stringValue, "XC")
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.C.stringValue, "C")
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.CD.stringValue, "CD")
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.D.stringValue, "D")
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.CM.stringValue, "CM")
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.M.stringValue, "M")
    }

    func test_lesserSymbol() {
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.nulla.lesserSymbol, nil)
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.I.lesserSymbol, nil)
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.IV.lesserSymbol, .I)
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.V.lesserSymbol, .IV)
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.IX.lesserSymbol, .V)
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.X.lesserSymbol, .IX)
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.XL.lesserSymbol, .X)
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.L.lesserSymbol, .XL)
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.XC.lesserSymbol, .L)
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.C.lesserSymbol, .XC)
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.CD.lesserSymbol, .C)
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.D.lesserSymbol, .CD)
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.CM.lesserSymbol, .D)
        XCTAssertEqual(SubtractiveRomanNumeralSymbol.M.lesserSymbol, .CM)
    }
}

// MARK: - RomanNumeralConvertible Tests

extension SubtractiveRomanNumeralSymbolTests {
    func test_subtractiveRomanNumeral() {
        for subtractiveSymbol in SubtractiveRomanNumeralSymbol.allSymbolsAscending {
            XCTAssertEqual(
                subtractiveSymbol.romanNumeral,
                try RomanNumeral(subtractiveSymbols: [subtractiveSymbol])
            )
        }
    }
}

// MARK: - SubtractiveRomanNumeralSymbolConvertible Tests

extension SubtractiveRomanNumeralSymbolTests {
    func test_subtractiveRomanNumeralSymbolConvertible() {
        for subtractiveSymbol in SubtractiveRomanNumeralSymbol.allSymbolsAscending {
            XCTAssertEqual(subtractiveSymbol.subtractiveRomanNumeralSymbol, subtractiveSymbol)
        }
    }
}

// MARK: - SubtractiveRomanNumeralSymbolsConvertible Tests

extension SubtractiveRomanNumeralSymbolTests {
    func test_subtractiveRomanNumeralSymbolsConvertible() {
        for subtractiveSymbol in SubtractiveRomanNumeralSymbol.allSymbolsAscending {
            XCTAssertEqual(subtractiveSymbol.subtractiveRomanNumeralSymbols, [subtractiveSymbol])
        }
    }
}
