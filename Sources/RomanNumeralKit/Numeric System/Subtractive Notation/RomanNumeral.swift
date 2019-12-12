//
//  RomanNumeral.swift
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
 A Roman numeral that represents its value using traditional symbols arranged in subtractive notation. The Roman numeral
 is condensed to its shortest representation using the fewest number of symbols.

 The value of a Roman numeral is generally accumalated by adding the symbols from left-to-right, where the symbols are
 arranged in order from greatest to least. Subtractive notation introduces an abbreviation for some groups of symbols
 in order to shorten the length of the overall Roman numeral. It is represented by a lesser symbol preceding a greater
 symbol in the writing of the Roman numeral and can typically be read as subtracting the lesser symbol from the greater
 symbol.

 For example, in subtractive notation *IIII* (4) becomes *IV`* (1 less than 5). Similarly, in subtractive
 notation *LXXXX* (90) becomes *XC* (10 less than 100).

 Only specific combinations of symbols are recognized as being valid subtractive syntax. They are as follows:

 - *IV* = 4
 - *IX* = 9
 - *XL* = 40
 - *XC* = 90
 - *CD* = 400
 - *CM* = 900

 The subtractive grouping of two symbols, when viewed as a singular value, still follows the rule that symbols are
 ordered from greatest to least.

 For example, *XC* must succeed all symbols (subtractive or singular) whose value is greater than 90 and must precede
 all symbols (subtractive or singular) whose value is less than 90. So *MDCXCIV* (1,694) is a valid Roman numeral but
 *MDXCCIV* is not.

 Conceptually, the Roman numeral is an abbreviation for the number of tally marks that are equal to the integer
 representation of the Roman numeral.

 See `RomanNumeralSymbolProtocol` and `RomanNumeralSymbol` for the definitions of the traditional symbols. Internally,
 `RomanNumeral` represents its value using `SubtractiveRomanNumeralSymbol`s to explicitly define the subtractive cases
 and make value conversions easier.

 - SeeAlso: https://en.wikipedia.org/wiki/Roman_numerals#Description
 */
public struct RomanNumeral: SubtractiveRomanNumeralSymbolsConvertible {
    // MARK: Public Static Properties

    public static let maximum = RomanNumeral(unsafeSymbols: [.M, .M, .M, .CM, .XC, .IX])
    public static let minimum = RomanNumeral(unsafeSymbols: [.I])

    // MARK: Public Instance Properties

    public private(set) var subtractiveRomanNumeralSymbols: [SubtractiveRomanNumeralSymbol]

    // MARK: Public Initialization

    /**
     Creates a new Roman numeral represented by the value of the given subtractive symbols.

     The given symbols must be in the appropriate order for subtractive notation.

     The given symbols will be condensed to the most succint representation using the fewest number of symbols. The
     symbols that are ultimately produced by the Roman numeral may not be the same symbols as the ones passed in, but
     the value will be equivalent.

     The value of the resulting Roman numeral must be within the `minimum` and `maximum` values for subtractive
     notation.

     This differs from the protocol-defined `init(symbols:)` by using the special `SubtractiveRomanNumeralSymbol` type.
     Both are valid ways to construct subtractive Roman numerals.

     - Parameter subtractiveSymbols: The subtractive symbols to construct the Roman numeral from.
     */
    public init(subtractiveSymbols: [SubtractiveRomanNumeralSymbol]) throws {
        guard subtractiveSymbols.isSorted(by: >=) else {
            throw RomanNumeralError.symbolsOutOfOrder
        }

        let condensedSubtractiveSymbols = RomanNumeral.condense(subtractiveSymbols: subtractiveSymbols)
        let potentialRomanNumeral = RomanNumeral(unsafeSymbols: condensedSubtractiveSymbols)

        guard RomanNumeral.minimum <= potentialRomanNumeral else {
            throw RomanNumeralError.valueLessThanMinimum
        }

        guard potentialRomanNumeral <= RomanNumeral.maximum else {
            throw RomanNumeralError.valueGreaterThanMaximum
        }

        self = potentialRomanNumeral
    }

    // MARK: Internal Initialization

    internal init(unsafeSymbols: [SubtractiveRomanNumeralSymbol]) {
        subtractiveRomanNumeralSymbols = unsafeSymbols
    }

    // MARK: Public Static Interface

    /**
     Condense the given subtractive symbols to their most succint representation using the fewest number of symbols.

     For example *VV* will be condensed to *X*.

     This differs from the protocol-defined `condense(symbols:)` by using the special `SubtractiveRomanNumeralSymbol`
     type. Both are valid ways to condense Roman numeral symbols.

     - Parameter subtractiveSymbols: The given subtractive symbols to condense.
     - Returns: The condensed form of the given subtractive symbols.
     */
    public static func condense(
        subtractiveSymbols: [SubtractiveRomanNumeralSymbol]
    ) -> [SubtractiveRomanNumeralSymbol] {
        var condenser = SubtractiveRomanNumeralSymbolCondenser()
        condenser.combine(symbols: subtractiveSymbols)

        return condenser.finalize()
    }

    /**
     Convert the given subtractive symbols into their cumulative integer value.

     The order of the symbols should follow subtractive notation rules.

     This differs from the protocol-defined `int(from:)` by using the special `SubtractiveRomanNumeralSymbol` type.
     Both are valid ways to convert symbols into integers.

     - Parameter symbols: The subtractive symbols that should be represented as a cumulative integer value.
     - Returns: The cumulative integer value of the given subtractive symbols.
     */
    public static func int(from subtractiveSymbols: [SubtractiveRomanNumeralSymbol]) -> Int {
        subtractiveSymbols.reduce(0) { $0 + $1.rawValue.tallyMarks.count }
    }

    /**
     Convert the given integer into the corresponding subtractive symbols.

     The returned symbols may not comprise a valid Roman numeral if the given integer value is not within the bounds
     defined by `minimum` and `maximum`.

     This differs from the protocol-defined `symbols(from:)` by using the special `SubtractiveRomanNumeralSymbol` type.
     Both are valid ways to convert integers into symbols.

     - Parameter intValue: The integer to convert into a collection of subtractive symbols.
     - Returns: The symbolic representation of the given integer.
     */
    public static func subtractiveSymbols(from intValue: Int) -> [SubtractiveRomanNumeralSymbol] {
        var remainingIntValue = intValue
        var convertedSubtractiveSymbols: [SubtractiveRomanNumeralSymbol] = []

        SubtractiveRomanNumeralSymbol.allSymbolsDescending.forEach { symbol in
            let symbolCount: Int = remainingIntValue / symbol.rawValue.tallyMarks.count

            guard symbolCount > 0 else {
                return
            }

            let consecutiveSymbols = Array(repeating: symbol, count: symbolCount)
            convertedSubtractiveSymbols.append(contentsOf: consecutiveSymbols)
            remainingIntValue -= symbolCount * symbol.rawValue.tallyMarks.count
        }

        return convertedSubtractiveSymbols
    }

    // MARK: Internal Static Interface

    /**
     Convert the given subtractive symbols into their `RomanNumeralSymbol` equivalents.

     The symbols will be converted directly and will come out in subtractive notation using the alternate symbol type.

     - Parameter subtractiveSymbols: The subtractive symbols to convert.
     - Returns: The `RomanNumeralSymbol` equivalent of the subtractive symbols.
     */
    internal static func convert(
        toSymbolEquivalentSymbols subtractiveSymbols: [SubtractiveRomanNumeralSymbol]
    ) -> [RomanNumeralSymbol] {
        subtractiveSymbols.flatMap { $0.romanNumeralSymbols }
    }

    /**
     Convert the given subtractive symbols into their `RomanNumeralSymbol` equivalent using additive notation.

     The symbols will come out in additive notation with the same value as their given subtractive counterparts.

     - Parameter subtractiveSymbols: The subtractive symbols to convert.
     - Returns: The `RomanNumeralSymbol` equivalent of the subtractive symbols in additive notation.
     */
    internal static func convert(
        toValueEquivalentSymbols subtractiveSymbols: [SubtractiveRomanNumeralSymbol]
    ) -> [RomanNumeralSymbol] {
        subtractiveSymbols.flatMap { $0.additiveRomanNumeralSymbols }
    }
}

// MARK: - AdditiveArithmetic Extension

extension RomanNumeral {
    // MARK: Public Static Interface

    public static func + (
        lhs: RomanNumeral,
        rhs: RomanNumeral
    ) -> RomanNumeral {
        let result: RomanNumeral
        do {
            result = try add(lhs: lhs, rhs: rhs)
        } catch {
            switch error {
            case RomanNumeralError.valueGreaterThanMaximum:
                result = RomanNumeral.maximum
            default:
                result = RomanNumeral.minimum
            }
        }

        return result
    }

    public static func += (lhs: inout RomanNumeral, rhs: RomanNumeral) {
        lhs = lhs + rhs
    }

    public static func - (
        lhs: RomanNumeral,
        rhs: RomanNumeral
    ) -> RomanNumeral {
        let result: RomanNumeral
        do {
            result = try subtract(lhs: lhs, rhs: rhs)
        } catch {
            switch error {
            case RomanNumeralError.valueGreaterThanMaximum:
                result = RomanNumeral.maximum
            default:
                result = RomanNumeral.minimum
            }
        }

        return result
    }

    public static func -= (lhs: inout RomanNumeral, rhs: RomanNumeral) {
        lhs = lhs - rhs
    }

    // MARK: Internal Static Interface

    /**
     - SeeAlso: http://turner.faculty.swau.edu/mathematics/materialslibrary/roman/
     */
    internal static func add(
        lhs: RomanNumeral,
        rhs: RomanNumeral
    ) throws -> RomanNumeral {
        guard
            let lhsAdditiveRomanNumeral = lhs.additiveRomanNumeral,
            let rhsAdditiveRomanNumeral = rhs.additiveRomanNumeral
        else {
            throw RomanNumeralArithmeticError.ambiguousAdditionError
        }

        guard
            let result = try AdditiveRomanNumeral.add(
                lhs: lhsAdditiveRomanNumeral,
                rhs: rhsAdditiveRomanNumeral
            )
            .romanNumeral
        else {
            throw RomanNumeralArithmeticError.ambiguousAdditionError
        }

        return result
    }

    /**
     - SeeAlso: http://turner.faculty.swau.edu/mathematics/materialslibrary/roman/
     */
    internal static func subtract(
        lhs: RomanNumeral,
        rhs: RomanNumeral
    ) throws -> RomanNumeral {
        guard
            let leftAdditiveRomanNumeral = lhs.additiveRomanNumeral,
            let rightAdditiveRomanNumeral = rhs.additiveRomanNumeral
        else {
            throw RomanNumeralArithmeticError.ambiguousSubtractionError
        }

        guard
            let result = try AdditiveRomanNumeral.subtract(
                lhs: leftAdditiveRomanNumeral,
                rhs: rightAdditiveRomanNumeral
            )
            .romanNumeral
        else {
            throw RomanNumeralArithmeticError.ambiguousSubtractionError
        }

        return result
    }
}

// MARK: - AdditiveRomanNumeralSymbolsConvertible Extension

extension RomanNumeral: AdditiveRomanNumeralSymbolsConvertible {
    // MARK: - Public Instance Interface

    public var additiveRomanNumeralSymbols: [RomanNumeralSymbol] {
        RomanNumeral.convert(toValueEquivalentSymbols: subtractiveRomanNumeralSymbols)
    }
}

// MARK: - Numeric Extension

extension RomanNumeral {
    // MARK: Public Typealiases

    public typealias Magnitude = UInt16

    // MARK: Public Initialization

    public init?<T>(exactly source: T) where T: BinaryInteger {
        try? self.init(from: Int(source))
    }

    // MARK: Public Static Interface

    public static func * (lhs: RomanNumeral, rhs: RomanNumeral) -> RomanNumeral {
        let result: RomanNumeral
        do {
            result = try multiply(lhs: lhs, rhs: rhs)
        } catch {
            switch error {
            case RomanNumeralError.valueGreaterThanMaximum:
                result = RomanNumeral.maximum
            default:
                result = RomanNumeral.minimum
            }
        }

        return result
    }

    public static func *= (lhs: inout RomanNumeral, rhs: RomanNumeral) {
        lhs = lhs * rhs
    }

    // MARK: Public Instance Interface

    public var magnitude: UInt16 {
        UInt16(tallyMarkGroup.tallyMarks.count)
    }

    // MARK: Internal Static Interface

    /**
     - SeeAlso: http://turner.faculty.swau.edu/mathematics/materialslibrary/roman/
     */
    internal static func multiply(
        lhs: RomanNumeral,
        rhs: RomanNumeral
    ) throws -> RomanNumeral {
        guard
            let lhsAdditiveRomanNumeral = lhs.additiveRomanNumeral,
            let rhsAdditiveRomanNumeral = rhs.additiveRomanNumeral
        else {
            throw RomanNumeralArithmeticError.ambiguousSubtractionError
        }

        guard
            let result = try AdditiveRomanNumeral.multiply(
                lhs: lhsAdditiveRomanNumeral,
                rhs: rhsAdditiveRomanNumeral
            )
            .romanNumeral
        else {
            throw RomanNumeralArithmeticError.ambiguousSubtractionError
        }

        return result
    }
}

// MARK: - RomanNumeralProtocol Extension

extension RomanNumeral: RomanNumeralProtocol {
    public typealias ToInt = SubtractiveRomanNumeralToIntConversionAlgorithm

    // MARK: Public Initialization

    public init(symbols: [RomanNumeralSymbol]) throws {
        let convertedSubtractiveSymbols = AdditiveRomanNumeral.convert(toSymbolEquivalentSubtractiveSymbols: symbols)
        try self.init(subtractiveSymbols: convertedSubtractiveSymbols)
    }

    // MARK: Public Static Interface

    public static func condense(symbols: [RomanNumeralSymbol]) -> [RomanNumeralSymbol] {
        var condenser = SubtractiveRomanNumeralSymbolCondenser()
        condenser.combine(symbols: symbols)

        return condenser.finalize()
    }

    public static func symbols(from intValue: Int) -> [RomanNumeralSymbol] {
        subtractiveSymbols(from: intValue).flatMap { $0.romanNumeralSymbols }
    }

    // MARK: Public Instance Interface

    public var symbols: [RomanNumeralSymbol] {
        RomanNumeral.convert(toSymbolEquivalentSymbols: subtractiveRomanNumeralSymbols)
    }

    public var tallyMarkGroup: RomanNumeralTallyMarkGroup {
        subtractiveRomanNumeralSymbols.reduce(.nulla) { $0 + $1.rawValue }
    }
}

// MARK: - RomanNumeralSymbolsConvertible Extension

extension RomanNumeral {
    // MARK: Public Instance Interface

    public var romanNumeralSymbols: [RomanNumeralSymbol] {
        RomanNumeral.convert(toSymbolEquivalentSymbols: subtractiveRomanNumeralSymbols)
    }
}

// MARK: - RomanNumeralConvertible Extension

extension RomanNumeral: RomanNumeralConvertible {
    // MARK: - Public Instance Interface

    public var romanNumeral: RomanNumeral? {
        self
    }
}
