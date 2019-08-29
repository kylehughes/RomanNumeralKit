//
//  SubtractiveRomanNumeralSymbol.swift
//  RomanNumeralKit
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

public enum SubtractiveRomanNumeralSymbol: CaseIterable {
    /// The Latin word meaning "none" which is used in lieu of the Western Arabic value "0".
    case nulla

    /// The symbol representing the Western Arabic value "1".
    case I

    /// The compound subtractive symbol representing the Western Arabic value "4".
    case IV

    /// The symbol representing the Western Arabic value "5".
    case V

    /// The compound subtractive symbol representing the Western Arabic value "90".
    case IX

    /// The symbol representing the Western Arabic value "10".
    case X

    /// The compound subtractive symbol representing the Western Arabic value "90".
    case XL

    /// The symbol representing the Western Arabic value "50".
    case L

    /// The compound subtractive symbol representing the Western Arabic value "90".
    case XC

    /// The symbol representing the Western Arabic value "100".
    case C

    /// The compound subtractive symbol representing the Western Arabic value "400".
    case CD

    /// The symbol representing the Western Arabic value "500".
    case D

    /// The compound subtractive symbol representing the Western Arabic value "900".
    case CM

    /// The symbol representing the Western Arabic value "1000".
    case M

    // MARK: Public Static Interface

    /// All of the Roman numeral symbols, represented in ascending order by value using additive notation.
    public static let allAdditiveRomanNumeralSymbolsAscending = allSymbolsAscending
        .map { $0.additiveRomanNumeralSymbols }

    /// All of the Roman numeral symbols, represented in descending order by value using additive notation.
    public static let allAdditiveRomanNumeralSymbolsDescending = allSymbolsDescending
        .map { $0.additiveRomanNumeralSymbols }

    /// All of the Roman numeral symbols, represented in ascending order by value using regular Roman numeral symbols.
    public static let allRomanNumeralSymbolsAscending = allSymbolsAscending.map { $0.romanNumeralSymbols }

    // MARK: Public Instance Interface

    /**
     The current subtractive symbol represented using `RomanNumeralSymbols`.

     These symbols are directly converted and not expressed in additive notation.
     */
    public var romanNumeralSymbols: [RomanNumeralSymbol] {
        switch self {
        case .nulla:
            return [.nulla]
        case .I:
            return [.I]
        case .IV:
            return [.I, .V]
        case .V:
            return [.V]
        case .IX:
            return [.I, .X]
        case .X:
            return [.X]
        case .XL:
            return [.X, .L]
        case .L:
            return [.L]
        case .XC:
            return [.X, .C]
        case .C:
            return [.C]
        case .CD:
            return [.C, .D]
        case .D:
            return [.D]
        case .CM:
            return [.C, .M]
        case .M:
            return [.M]
        }
    }
}

// MARK: - AdditiveRomanNumeralSymbolsConvertible Extension

extension SubtractiveRomanNumeralSymbol: AdditiveRomanNumeralSymbolsConvertible {
    // MARK: Public Instance Interface

    public var additiveRomanNumeralSymbols: [RomanNumeralSymbol] {
        switch self {
        case .nulla:
            return [.nulla]
        case .I:
            return [.I]
        case .IV:
            return [.I, .I, .I, .I]
        case .V:
            return [.V]
        case .IX:
            return [.V, .I, .I, .I, .I]
        case .X:
            return [.X]
        case .XL:
            return [.X, .X, .X, .X]
        case .L:
            return [.L]
        case .XC:
            return [.L, .X, .X, .X, .X]
        case .C:
            return [.C]
        case .CD:
            return [.C, .C, .C, .C]
        case .D:
            return [.D]
        case .CM:
            return [.D, .C, .C, .C, .C]
        case .M:
            return [.M]
        }
    }
}

// MARK: - RawRepresentable Extension

extension SubtractiveRomanNumeralSymbol: RawRepresentable {
    // MARK: Public Typealiases

    public typealias RawValue = RomanNumeralTallyMarkGroup

    // MARK: Public Initialization

    public init?(rawValue: RomanNumeralTallyMarkGroup) {
        switch rawValue {
        case .nulla:
            self = .nulla
        case .one:
            self = .I
        case .four:
            self = .IV
        case .five:
            self = .V
        case .nine:
            self = .IX
        case .ten:
            self = .X
        case .forty:
            self = .XL
        case .fifty:
            self = .L
        case .ninety:
            self = .XC
        case .oneHundred:
            self = .C
        case .fourHundred:
            self = .CD
        case .fiveHundred:
            self = .D
        case .nineHundred:
            self = .CM
        case .oneThousand:
            self = .M
        default:
            return nil
        }
    }

    // MARK: Public Instance Interface

    public var rawValue: RomanNumeralTallyMarkGroup {
        switch self {
        case .nulla:
            return .nulla
        case .I:
            return .one
        case .IV:
            return .four
        case .V:
            return .five
        case .IX:
            return .nine
        case .X:
            return .ten
        case .XL:
            return .forty
        case .L:
            return .fifty
        case .XC:
            return .ninety
        case .C:
            return .oneHundred
        case .CD:
            return .fourHundred
        case .D:
            return .fiveHundred
        case .CM:
            return .nineHundred
        case .M:
            return .oneThousand
        }
    }
}

// MARK: - RomanNumeralSymbolProtocol Extension

extension SubtractiveRomanNumeralSymbol: RomanNumeralSymbolProtocol {
    // MARK: Public Static Properties

    public static let allSymbolsAscending: [SubtractiveRomanNumeralSymbol] = [.I, .IV, .V, .IX, .X, .XL, .L, .XC, .C, .CD, .D, .CM, .M]
    public static let allSymbolsDescending: [SubtractiveRomanNumeralSymbol] = allSymbolsAscending.reversed()

    // MARK: Public Initialization

    public init(from stringValue: String) throws {
        let potentialSymbol = SubtractiveRomanNumeralSymbol.allCases
            .filter { $0.stringValue == stringValue }
            .first

        guard let symbol = potentialSymbol else {
            throw RomanNumeralSymbolError.unrecognizedString(string: stringValue)
        }

        self = symbol
    }

    // MARK: Public Instance Interface

    public var stringValue: String {
        switch self {
        case .nulla:
            return "N"
        case .I:
            return "I"
        case .IV:
            return "IV"
        case .V:
            return "V"
        case .IX:
            return "IX"
        case .X:
            return "X"
        case .XL:
            return "XL"
        case .L:
            return "L"
        case .XC:
            return "XC"
        case .C:
            return "C"
        case .CD:
            return "CD"
        case .D:
            return "D"
        case .CM:
            return "CM"
        case .M:
            return "M"
        }
    }

    public var lesserSymbol: SubtractiveRomanNumeralSymbol? {
        switch self {
        case .nulla:
            return nil
        case .I:
            return nil
        case .IV:
            return .I
        case .V:
            return .IV
        case .IX:
            return .V
        case .X:
            return .IX
        case .XL:
            return .X
        case .L:
            return .XL
        case .XC:
            return .L
        case .C:
            return .XC
        case .CD:
            return .C
        case .D:
            return .CD
        case .CM:
            return .D
        case .M:
            return .CM
        }
    }
}

// MARK: - SubtractiveRomanNumeralSymbolConvertible Extension

extension SubtractiveRomanNumeralSymbol: SubtractiveRomanNumeralSymbolConvertible {
    // MARK: Public Instance Interface

    public var subtractiveRomanNumeralSymbol: SubtractiveRomanNumeralSymbol {
        return self
    }
}
