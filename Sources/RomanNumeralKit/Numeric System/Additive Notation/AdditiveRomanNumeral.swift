//
//  AdditiveRomanNumeral.swift
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
 A Roman numeral that represents its value using traditional symbols arranged in additive notation. The Roman numeral
 is condensed to its shortest representation using the fewest number of symbols.

 The value of an additive Roman numeral is accumalated by adding the symbols from left-to-right, where the symbols are
 arranged in order from greatest to least.

 For example, in additive notation *IIII* equals 4, and *VIIII* equals 9. There are no abbreviations like in
 subtractive notation.

 Conceptually, the Roman numeral is an abbreviation for the number of tally marks that are equal to the integer
 representation of the Roman numeral.

 See `RomanNumeralSymbolProtocol` and `RomanNumeralSymbol` for the definitions of the traditional symbols.

 - SeeAlso: https://en.wikipedia.org/wiki/Roman_numerals#Use_of_additive_notation
 */
public struct AdditiveRomanNumeral: AdditiveRomanNumeralSymbolsConvertible {
    // MARK: Public Static Properties

    public static let maximum = AdditiveRomanNumeral(unsafeSymbols: [.M, .M, .M, .D, .C, .C, .C, .C, .L, .X, .X, .X, .X, .V, .I, .I, .I, .I])
    public static let minimum = AdditiveRomanNumeral(unsafeSymbols: [.I])

    // MARK: Public Instance Properties

    public private(set) var additiveRomanNumeralSymbols: [RomanNumeralSymbol]

    // MARK: Internal Initialization

    internal init(unsafeSymbols: [RomanNumeralSymbol]) {
        additiveRomanNumeralSymbols = unsafeSymbols
    }

    // MARK: Internal Static Interface

    /**
     Convert the given additive symbols into their `SubtractiveRomanNumeralSymbol` equivalents.

     The symbols will be converted directly and will come out in additive notation using the alternate symbol type.

     - Parameter additiveSymbols: The additive symbols to convert.
     - Returns: The `SubtractiveRomanNumeralSymbol` equivalent of the additive symbols.
     */
    internal static func convert(
        toSymbolEquivalentSubtractiveSymbols additiveSymbols: [RomanNumeralSymbol]
    ) -> [SubtractiveRomanNumeralSymbol] {
        var lastProcessedIndex = -1

        return additiveSymbols
            .lazy
            .enumerated()
            .compactMap { index, additiveSymbol in
                guard lastProcessedIndex < index else {
                    return nil
                }

                let nextIndex = index + 1

                guard nextIndex < additiveSymbols.count else {
                    lastProcessedIndex = index

                    return additiveSymbol.subtractiveRomanNumeralSymbol
                }

                let nextAdditiveSymbol = additiveSymbols[nextIndex]

                guard
                    let subtractiveSymbolIndex = SubtractiveRomanNumeralSymbol.allRomanNumeralSymbolsAscending
                    .firstIndex(of: [additiveSymbol, nextAdditiveSymbol])
                else {
                    lastProcessedIndex = index

                    return additiveSymbol.subtractiveRomanNumeralSymbol
                }

                lastProcessedIndex = nextIndex

                return SubtractiveRomanNumeralSymbol.allSymbolsAscending[subtractiveSymbolIndex]
            }
    }

    /**
     Convert the given additive symbols into their `SubtractiveRomanNumeralSymbol` equivalent using subtractive
     notation.

     The symbols will come out in subtractive notation with the same value as their given additive counterparts.

     - Parameter additiveSymbols: The additive symbols to convert.
     - Returns: The `SubtractiveRomanNumeralSymbol` equivalent of the additive symbols in subtractive notation.
     */
    internal static func convert(
        toValueEquivalentSubtractiveSymbols additiveSymbols: [RomanNumeralSymbol]
    ) -> [SubtractiveRomanNumeralSymbol] {
        let enumeratedConvertedSubtractiveSymbols = SubtractiveRomanNumeralSymbol
            .allAdditiveRomanNumeralSymbolsDescending
            .enumerated()

        var remainingAdditiveSymbols = additiveSymbols.filter { $0 != .nulla }
        var subtractiveSymbols: [SubtractiveRomanNumeralSymbol] = []

        while !remainingAdditiveSymbols.isEmpty {
            for (index, convertedSubtractiveSymbols) in enumeratedConvertedSubtractiveSymbols {
                guard remainingAdditiveSymbols.starts(with: convertedSubtractiveSymbols) else {
                    continue
                }

                let subtractiveSymbol = SubtractiveRomanNumeralSymbol.allSymbolsDescending[index]
                subtractiveSymbols.append(subtractiveSymbol)
                remainingAdditiveSymbols.removeSubrange(0 ..< convertedSubtractiveSymbols.count)

                break
            }
        }

        return subtractiveSymbols
    }
}

// MARK: - AdditiveArithmetic Extension

extension AdditiveRomanNumeral {
    // MARK: Public Static Interface

    public static func + (
        lhs: AdditiveRomanNumeral,
        rhs: AdditiveRomanNumeral
    ) -> AdditiveRomanNumeral {
        let result: AdditiveRomanNumeral
        do {
            result = try add(lhs: lhs, rhs: rhs)
        } catch {
            switch error {
            case RomanNumeralError.valueGreaterThanMaximum:
                result = AdditiveRomanNumeral.maximum
            default:
                result = AdditiveRomanNumeral.minimum
            }
        }

        return result
    }

    public static func += (lhs: inout AdditiveRomanNumeral, rhs: AdditiveRomanNumeral) {
        lhs = lhs + rhs
    }

    public static func - (
        lhs: AdditiveRomanNumeral,
        rhs: AdditiveRomanNumeral
    ) -> AdditiveRomanNumeral {
        let result: AdditiveRomanNumeral
        do {
            result = try subtract(lhs: lhs, rhs: rhs)
        } catch {
            switch error {
            case RomanNumeralError.valueGreaterThanMaximum:
                result = AdditiveRomanNumeral.maximum
            default:
                result = AdditiveRomanNumeral.minimum
            }
        }

        return result
    }

    public static func -= (lhs: inout AdditiveRomanNumeral, rhs: AdditiveRomanNumeral) {
        lhs = lhs - rhs
    }

    // MARK: Internal Static Interface

    /**
     - SeeAlso: http://turner.faculty.swau.edu/mathematics/materialslibrary/roman/
     */
    internal static func add(
        lhs: AdditiveRomanNumeral,
        rhs: AdditiveRomanNumeral
    ) throws -> AdditiveRomanNumeral {
        let concatenatedSymbols = lhs.additiveRomanNumeralSymbols + rhs.additiveRomanNumeralSymbols
        let condensedSymbols = AdditiveRomanNumeral.condense(symbols: concatenatedSymbols)

        return try AdditiveRomanNumeral(symbols: condensedSymbols)
    }

    /**
     - SeeAlso: http://turner.faculty.swau.edu/mathematics/materialslibrary/roman/
     */
    internal static func subtract(
        lhs: AdditiveRomanNumeral,
        rhs: AdditiveRomanNumeral
    ) throws -> AdditiveRomanNumeral {
        var eliminationResult = eliminateCommonSymbols(
            betweenLeft: lhs.additiveRomanNumeralSymbols,
            andRight: rhs.additiveRomanNumeralSymbols
        )

        while !eliminationResult.right.isEmpty {
            let expandedRemainingLeftSymbols = try expandLargestSymbol(
                fromRight: eliminationResult.right,
                inLeft: eliminationResult.left
            )
            eliminationResult = eliminateCommonSymbols(
                betweenLeft: expandedRemainingLeftSymbols,
                andRight: eliminationResult.right
            )
        }

        return try AdditiveRomanNumeral(symbols: eliminationResult.left)
    }

    // MARK: Private Static Interface

    private static func eliminateCommonSymbols(
        betweenLeft left: [RomanNumeralSymbol],
        andRight right: [RomanNumeralSymbol]
    ) -> (left: [RomanNumeralSymbol], right: [RomanNumeralSymbol]) {
        var remainingLeftSymbols = left
        var remainingRightSymbols = right

        for rightSymbol in remainingRightSymbols.reversed() {
            guard
                let lastSymbolIndexInLeft = remainingLeftSymbols.lastIndex(of: rightSymbol),
                let rightSymbolIndex = remainingRightSymbols.lastIndex(of: rightSymbol)
            else {
                continue
            }

            remainingLeftSymbols.remove(at: lastSymbolIndexInLeft)
            remainingRightSymbols.remove(at: rightSymbolIndex)
        }

        return (left: remainingLeftSymbols, right: remainingRightSymbols)
    }

    private static func expandLargestSymbol(
        fromRight right: [RomanNumeralSymbol],
        inLeft left: [RomanNumeralSymbol]
    ) throws -> [RomanNumeralSymbol] {
        guard let greatestRightSymbol = right.max() else {
            throw RomanNumeralArithmeticError.ambiguousSubtractionError
        }

        let leftEnumeration = Array(left.enumerated())

        guard let greaterLeftSymbolEnumeration = leftEnumeration.last(where: { greatestRightSymbol < $1 }) else {
            throw RomanNumeralArithmeticError.ambiguousSubtractionError
        }

        var expandedGreaterLeftSymbols: [RomanNumeralSymbol] = greaterLeftSymbolEnumeration
            .element
            .expandedIntoLesserSymbol

        while
            let expandedGreaterLeftSymbol = expandedGreaterLeftSymbols.first,
            expandedGreaterLeftSymbol != greatestRightSymbol {
            expandedGreaterLeftSymbols = expandedGreaterLeftSymbols.flatMap { $0.expandedIntoLesserSymbol }
        }

        guard !expandedGreaterLeftSymbols.isEmpty else {
            throw RomanNumeralArithmeticError.subtractionWhereRightValueIsGreaterThanLeftValue
        }

        let greaterLeftSymbolRange = greaterLeftSymbolEnumeration.offset ... greaterLeftSymbolEnumeration.offset

        var newLeftSymbols = left
        newLeftSymbols.replaceSubrange(greaterLeftSymbolRange, with: expandedGreaterLeftSymbols)

        return newLeftSymbols
    }
}

// MARK: - AdditiveRomanNumeralConvertible Extension

extension AdditiveRomanNumeral: AdditiveRomanNumeralConvertible {
    // MARK: Public Instance Interface

    public var additiveRomanNumeral: AdditiveRomanNumeral? {
        self
    }
}

// MARK: - Numeric Extension

extension AdditiveRomanNumeral {
    // MARK: Public Typealiases

    public typealias Magnitude = UInt16

    // MARK: Public Initialization

    public init?<T>(exactly source: T) where T: BinaryInteger {
        try? self.init(from: Int(source))
    }

    // MARK: Public Static Interface

    public static func * (lhs: AdditiveRomanNumeral, rhs: AdditiveRomanNumeral) -> AdditiveRomanNumeral {
        let result: AdditiveRomanNumeral
        do {
            result = try multiply(lhs: lhs, rhs: rhs)
        } catch {
            switch error {
            case RomanNumeralError.valueGreaterThanMaximum:
                result = AdditiveRomanNumeral.maximum
            default:
                result = AdditiveRomanNumeral.minimum
            }
        }

        return result
    }

    public static func *= (lhs: inout AdditiveRomanNumeral, rhs: AdditiveRomanNumeral) {
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
    internal static func multiply(lhs: AdditiveRomanNumeral, rhs: AdditiveRomanNumeral) throws -> AdditiveRomanNumeral {
        var unsortedSymbolsFromProduct: [RomanNumeralSymbol] = []
        for lhsSymbol in lhs.symbols {
            for rhsSymbol in rhs.symbols {
                unsortedSymbolsFromProduct.append(contentsOf: lhsSymbol * rhsSymbol)
            }
        }

        let sortedSymbolsFromProduct = unsortedSymbolsFromProduct.sorted { $0 > $1 }

        return try AdditiveRomanNumeral(symbols: sortedSymbolsFromProduct)
    }
}

// MARK: - RomanNumeralProtocol Extension

extension AdditiveRomanNumeral: RomanNumeralProtocol {
    // MARK: Public Initialization

    public init(symbols: [RomanNumeralSymbol]) throws {
        guard symbols.isSorted(by: >=) else {
            throw RomanNumeralError.symbolsOutOfOrder
        }

        let condensedSymbols = AdditiveRomanNumeral.condense(symbols: symbols)
        let potentialRomanNumeral = AdditiveRomanNumeral(unsafeSymbols: condensedSymbols)

        guard AdditiveRomanNumeral.minimum <= potentialRomanNumeral else {
            throw RomanNumeralError.valueLessThanMinimum
        }

        guard potentialRomanNumeral <= AdditiveRomanNumeral.maximum else {
            throw RomanNumeralError.valueGreaterThanMaximum
        }

        self = potentialRomanNumeral
    }

    // MARK: Public Static Interface

    public static func condense(symbols: [RomanNumeralSymbol]) -> [RomanNumeralSymbol] {
        var condenser = AdditiveRomanNumeralSymbolCondenser()
        condenser.combine(symbols: symbols)

        return condenser.finalize()
    }

    public static func int(from symbols: [RomanNumeralSymbol]) -> Int {
        symbols.reduce(0) { $0 + $1.rawValue.tallyMarks.count }
    }

    public static func symbols(from intValue: Int) -> [RomanNumeralSymbol] {
        var remainingIntValue = intValue
        var convertedSymbols: [RomanNumeralSymbol] = []

        RomanNumeralSymbol.allSymbolsDescending.forEach { symbol in
            let symbolCount: Int = remainingIntValue / symbol.rawValue.tallyMarks.count
            guard symbolCount > 0 else {
                return
            }

            let consecutiveSymbols = Array(repeating: symbol, count: symbolCount)
            convertedSymbols.append(contentsOf: consecutiveSymbols)
            remainingIntValue -= symbolCount * symbol.rawValue.tallyMarks.count
        }

        return convertedSymbols
    }

    // MARK: Public Instance Interface

    public var symbols: [RomanNumeralSymbol] {
        additiveRomanNumeralSymbols
    }

    public var tallyMarkGroup: RomanNumeralTallyMarkGroup {
        symbols.reduce(.nulla) { $0 + $1.rawValue }
    }
}

// MARK: - RomanNumeralSymbolsConvertible Extension

extension AdditiveRomanNumeral {
    // MARK: Public Instance Interface

    public var romanNumeralSymbols: [RomanNumeralSymbol] {
        let subtractiveSymbols = AdditiveRomanNumeral.convert(
            toValueEquivalentSubtractiveSymbols: additiveRomanNumeralSymbols
        )

        return RomanNumeral.convert(toSymbolEquivalentSymbols: subtractiveSymbols)
    }
}
