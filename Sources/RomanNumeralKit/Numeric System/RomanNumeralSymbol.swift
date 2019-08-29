//
//  RomanNumeralSymbol.swift
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

/**
 Roman numeral symbols are a collection of letters from the Latin alphabet that are used to represent numbers in the
 numeric system of ancient Rome. Each symbol is shorthand for a specific number of tally marks.

 Traditional Roman numerals employ seven symbols, each with a fixed integer value. The number 0 does not have its own
 Roman numeral symbol, but the word "nulla" (the Latin word meaning "none") is used in lieu of 0.

 The backing values of the Roman numeral symbols, as found in their `rawValue`, are `RomanNumeralTallyMarkGroups` which
 are used to collect all of the corresponding `RomanNumeralTallyMark`s. Any representations of the symbols as Arabic
 numerals (e.g. `Int`) are conversions made by counting these tally marks.
 */
public enum RomanNumeralSymbol: CaseIterable {
    /// The Latin word meaning "none" which is used in lieu of the Western Arabic value "0".
    case nulla

    /// The symbol representing the Western Arabic value "1".
    case I

    /// The symbol representing the Western Arabic value "5".
    case V

    /// The symbol representing the Western Arabic value "10".
    case X

    /// The symbol representing the Western Arabic value "50".
    case L

    /// The symbol representing the Western Arabic value "100".
    case C

    /// The symbol representing the Western Arabic value "500".
    case D

    /// The symbol representing the Western Arabic value "1000".
    case M

    // MARK: Public Static Interface

    public static func * (
        lhs: RomanNumeralSymbol,
        rhs: RomanNumeralSymbol
    ) -> [RomanNumeralSymbol] {
        switch lhs {
        case .nulla:
            return []
        case .I:
            switch rhs {
            case .nulla:
                return []
            default:
                return [rhs]
            }
        case .V:
            switch rhs {
            case .nulla:
                return []
            case .I:
                return [.V]
            case .V:
                return [.X, .X, .V]
            case .X:
                return [.L]
            case .L:
                return [.C, .C, .L]
            case .C:
                return [.D]
            case .D:
                return [.M, M, .D]
            case .M:
                return Array(repeating: .M, count: 5)
            }
        case .X:
            switch rhs {
            case .nulla:
                return []
            case .I:
                return [.X]
            case .V:
                return [.L]
            case .X:
                return [.C]
            case .L:
                return [.D]
            case .C:
                return [.M]
            case .D:
                return Array(repeating: .M, count: 5)
            case .M:
                return Array(repeating: .M, count: 10)
            }
        case .L:
            switch rhs {
            case .nulla:
                return []
            case .I:
                return [.L]
            case .V:
                return [.C, .C, .L]
            case .X:
                return [.D]
            case .L:
                return [.M, .M, .D]
            case .C:
                return Array(repeating: .M, count: 5)
            case .D:
                return Array(repeating: .M, count: 25)
            case .M:
                return Array(repeating: .M, count: 50)
            }
        case .C:
            switch rhs {
            case .nulla:
                return []
            case .I:
                return [.C]
            case .V:
                return [.D]
            case .X:
                return [.M]
            case .L:
                return Array(repeating: .M, count: 5)
            case .C:
                return Array(repeating: .M, count: 10)
            case .D:
                return Array(repeating: .M, count: 50)
            case .M:
                return Array(repeating: .M, count: 100)
            }
        case .D:
            switch rhs {
            case .nulla:
                return []
            case .I:
                return [.D]
            case .V:
                return [.M, .M, .D]
            case .X:
                return Array(repeating: .M, count: 5)
            case .L:
                return Array(repeating: .M, count: 25)
            case .C:
                return Array(repeating: .M, count: 50)
            case .D:
                return Array(repeating: .M, count: 250)
            case .M:
                return Array(repeating: .M, count: 500)
            }
        case .M:
            switch rhs {
            case .nulla:
                return []
            case .I:
                return [.M]
            case .V:
                return Array(repeating: .M, count: 5)
            case .X:
                return Array(repeating: .M, count: 10)
            case .L:
                return Array(repeating: .M, count: 50)
            case .C:
                return Array(repeating: .M, count: 100)
            case .D:
                return Array(repeating: .M, count: 500)
            case .M:
                return Array(repeating: .M, count: 1000)
            }
        }
    }

    // MARK: Public Instance Interface

    /**
     The representation of the current Roman numeral symbol as a collection of its lesser symbol.

     For example, the expansion of `L` is equal to `XXXXX`.

     - Note: The expansion of `I` is its identity because it has no lesser symbol with a valid value. The expansion of
     `nulla` is an empty `Array` for the same reason.
     */
    public var expandedIntoLesserSymbol: [RomanNumeralSymbol] {
        switch self {
        case .nulla:
            return []
        case .I:
            return [.I]
        case .V:
            return [.I, .I, .I, .I, .I]
        case .X:
            return [.V, .V]
        case .L:
            return [.X, .X, .X, .X, .X]
        case .C:
            return [.L, .L]
        case .D:
            return [.C, .C, .C, .C, .C]
        case .M:
            return [.D, .D]
        }
    }
}

// MARK: - AdditiveRomanNumeralSymbolConvertible Extension

extension RomanNumeralSymbol: AdditiveRomanNumeralSymbolConvertible {
    // MARK: Public Instance Interface

    public var additiveRomanNumeralSymbol: RomanNumeralSymbol {
        return self
    }
}

// MARK: - RawRepresentable Extension

extension RomanNumeralSymbol: RawRepresentable {
    // MARK: Public Typealiases

    public typealias RawValue = RomanNumeralTallyMarkGroup

    // MARK: Public Initialization

    public init?(rawValue: RomanNumeralTallyMarkGroup) {
        switch rawValue {
        case .nulla:
            self = .nulla
        case .one:
            self = .I
        case .five:
            self = .V
        case .ten:
            self = .X
        case .fifty:
            self = .L
        case .oneHundred:
            self = .C
        case .fiveHundred:
            self = .D
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
        case .V:
            return .five
        case .X:
            return .ten
        case .L:
            return .fifty
        case .C:
            return .oneHundred
        case .D:
            return .fiveHundred
        case .M:
            return .oneThousand
        }
    }
}

// MARK: - RomanNumeralSymbolConvertible Extension

extension RomanNumeralSymbol: RomanNumeralSymbolConvertible {
    // MARK: Public Instance Interface

    public var romanNumeralSymbol: RomanNumeralSymbol {
        return self
    }
}

// MARK: - RomanNumeralSymbolProtocol Extension

extension RomanNumeralSymbol: RomanNumeralSymbolProtocol {
    // MARK: Public Static Properties

    public static let allSymbolsAscending: [RomanNumeralSymbol] = [.I, .V, .X, .L, .C, .D, .M]

    public static let allSymbolsDescending: [RomanNumeralSymbol] = allSymbolsAscending.reversed()

    // MARK: Public Initialization

    public init(from stringValue: String) throws {
        let potentialSymbol = RomanNumeralSymbol.allCases
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
        case .V:
            return "V"
        case .X:
            return "X"
        case .L:
            return "L"
        case .C:
            return "C"
        case .D:
            return "D"
        case .M:
            return "M"
        }
    }

    public var lesserSymbol: RomanNumeralSymbol? {
        switch self {
        case .nulla:
            return nil
        case .I:
            return nil
        case .V:
            return .I
        case .X:
            return .V
        case .L:
            return .X
        case .C:
            return .L
        case .D:
            return .C
        case .M:
            return .D
        }
    }
}

// MARK: - SubtractiveRomanNumeralSymbolConvertible Extension

extension RomanNumeralSymbol: SubtractiveRomanNumeralSymbolConvertible {
    // MARK: Public Instance Interface

    public var subtractiveRomanNumeralSymbol: SubtractiveRomanNumeralSymbol {
        switch self {
        case .nulla:
            return .nulla
        case .I:
            return .I
        case .V:
            return .V
        case .X:
            return .X
        case .L:
            return .L
        case .C:
            return .C
        case .D:
            return .D
        case .M:
            return .M
        }
    }
}

// MARK: - SubtractiveRomanNumeralSymbolsConvertible Extension

extension RomanNumeralSymbol: SubtractiveRomanNumeralSymbolsConvertible {
    // MARK: Public Instance Interface

    public var subtractiveRomanNumeralSymbols: [SubtractiveRomanNumeralSymbol] {
        return [subtractiveRomanNumeralSymbol]
    }
}
