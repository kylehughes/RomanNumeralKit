//
//  BasicNotationRomanNumeral.swift
//  RomanNumeralKit
//
//  Created by Kyle Hughes on 9/30/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation

public struct BasicNotationRomanNumeral {

    // MARK: Public Instance Properties

    public private(set) var symbols: [RomanNumeralSymbol]

    // MARK: Internal Initialization

    internal init(unsafeSymbols: [RomanNumeralSymbol]) {
        symbols = unsafeSymbols
    }

    // MARK: Private Static Interface

    private static func intValue(fromSymbols symbols: [RomanNumeralSymbol]) -> Int {
        return symbols.reduce(0) { $0 + $1.rawValue.tallyMarks.count }
    }

    private static func symbols(fromIntValue intValue: Int) -> [RomanNumeralSymbol] {
        var remainingIntValue = intValue
        var convertedSymbols: [RomanNumeralSymbol] = []

        RomanNumeralSymbol.allSymbolsDescending.forEach { symbol in
            let symbolCount: Int = remainingIntValue / symbol.rawValue.tallyMarks.count
            guard 0 < symbolCount else {
                return
            }

            let consecutiveSymbols = Array(repeating: symbol, count: symbolCount)
            convertedSymbols.append(contentsOf: consecutiveSymbols)
            remainingIntValue -= symbolCount * symbol.rawValue.tallyMarks.count
        }

        return convertedSymbols
    }

}

// MARK: - Operators Extension

extension BasicNotationRomanNumeral {

    // MARK: Public Static Interface

    /**
     - SeeAlso: http://turner.faculty.swau.edu/mathematics/materialslibrary/roman/
     */
    public static func + (
        left: BasicNotationRomanNumeral,
        right: BasicNotationRomanNumeral
        ) -> BasicNotationRomanNumeral {

        let result: BasicNotationRomanNumeral
        do {
            result = try add(left: left, right: right)
        } catch {
            switch error {
            case RomanNumeralError.valueLessThanMinimum:
                result = BasicRomanNumeralNotation.minimum
            case RomanNumeralError.valueGreaterThanMaximum:
                result = BasicRomanNumeralNotation.maximum
            default:
                result = BasicRomanNumeralNotation.minimum
            }
        }

        return result
    }

    /**
     - SeeAlso: http://turner.faculty.swau.edu/mathematics/materialslibrary/roman/
     */
    public static func - (
        left: BasicNotationRomanNumeral,
        right: BasicNotationRomanNumeral
        ) -> BasicNotationRomanNumeral {

        let result: BasicNotationRomanNumeral
        do {
            result = try subtract(left: left, right: right)
        } catch {
            switch error {
            case RomanNumeralError.valueLessThanMinimum:
                result = BasicRomanNumeralNotation.minimum
            case RomanNumeralError.valueGreaterThanMaximum:
                result = BasicRomanNumeralNotation.maximum
            default:
                result = BasicRomanNumeralNotation.minimum
            }
        }

        return result
    }

    // MARK: Internal Static Interface

    internal static func add(
        left: BasicNotationRomanNumeral,
        right: BasicNotationRomanNumeral
        ) throws -> BasicNotationRomanNumeral {

        let concatenatedSymbols = left.symbols + right.symbols
        let condensedSymbols = BasicRomanNumeralNotation.condense(symbols: concatenatedSymbols)

        return try BasicNotationRomanNumeral(symbols: condensedSymbols)
    }

    internal static func subtract(
        left: BasicNotationRomanNumeral,
        right: BasicNotationRomanNumeral
        ) throws -> BasicNotationRomanNumeral {

        var eliminationResult = eliminateCommonSymbols(betweenLeft: left.symbols, andRight: right.symbols)

        while !eliminationResult.right.isEmpty {
            let expandedRemainingLeftSymbols = try expandLargestSymbol(
                fromRight: eliminationResult.right,
                inLeft: eliminationResult.left)
            eliminationResult = eliminateCommonSymbols(
                betweenLeft: expandedRemainingLeftSymbols,
                andRight: eliminationResult.right)
        }

        return try BasicNotationRomanNumeral(symbols: eliminationResult.left)
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

        let greaterLeftSymbolRange = greaterLeftSymbolEnumeration.offset...greaterLeftSymbolEnumeration.offset

        var newLeftSymbols = left
        newLeftSymbols.replaceSubrange(greaterLeftSymbolRange, with: expandedGreaterLeftSymbols)

        return newLeftSymbols
    }

}

// MARK: - BasicNotationRomanNumeralConvertible Extension

extension BasicNotationRomanNumeral: BasicNotationRomanNumeralConvertible {

    // MARK: Public Instance Interface

    public var basicNotationRomanNumeral: BasicNotationRomanNumeral? {
        return self
    }

}

// MARK: - BasicNotationRomanNumeralSymbolsConvertible Extension

extension BasicNotationRomanNumeral: BasicNotationRomanNumeralSymbolsConvertible {

    // MARK: Public Instance Interface

    public var basicNotationRomanNumeralSymbols: [RomanNumeralSymbol] {
        return symbols
    }

}

// MARK: - Comparable Extension

extension BasicNotationRomanNumeral: Comparable {

    // MARK: Public Static Interface

    public static func < (lhs: BasicNotationRomanNumeral, rhs: BasicNotationRomanNumeral) -> Bool {
        guard lhs != rhs else {
            return false
        }

        //TODO: Figure out how to use subtraction for this comparison (causes stack overflow currently)
        return
            lhs.symbols.flatMap { $0.rawValue.tallyMarks }.count <
                rhs.symbols.flatMap { $0.rawValue.tallyMarks }.count
    }

}

// MARK: - ExpressibleByStringLiteral Extension

extension BasicNotationRomanNumeral: ExpressibleByStringLiteral {

    public init(stringLiteral: String) {
        try! self.init(from: stringLiteral)
    }

}

// MARK: - RomanNumeralProtocol Extension

extension BasicNotationRomanNumeral: RomanNumeralProtocol {

    // MARK: Public Initialization

    public init(symbols: [RomanNumeralSymbol]) throws {
        guard symbols.isSorted(by: >=) else {
            throw RomanNumeralError.symbolsOutOfOrder
        }

        let condensedSymbols = BasicRomanNumeralNotation.condense(symbols: symbols)
        let potentialRomanNumeral = BasicNotationRomanNumeral(unsafeSymbols: condensedSymbols)

        guard BasicRomanNumeralNotation.minimum <= potentialRomanNumeral else {
            throw RomanNumeralError.valueLessThanMinimum
        }

        guard potentialRomanNumeral <= BasicRomanNumeralNotation.maximum else {
            throw RomanNumeralError.valueGreaterThanMaximum
        }

        self = potentialRomanNumeral
    }

}
