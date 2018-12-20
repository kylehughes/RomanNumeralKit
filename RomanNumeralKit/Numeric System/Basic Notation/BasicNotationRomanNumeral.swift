//
//  BasicNotationRomanNumeral.swift
//  RomanNumeralKit
//
//  Created by Kyle Hughes on 9/30/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation

public struct BasicNotationRomanNumeral {

    // MARK: Public Static Properties

    public static let maximumIntValue = 3999
    public static let minimumIntValue = 1

    // MARK: Public Properties

    public private(set) var stringValue: String
    public private(set) var symbols: [RomanNumeralSymbol]

    public var intValue: Int {
        didSet {
            symbols = BasicNotationRomanNumeral.symbols(fromIntValue: intValue)
            stringValue = BasicNotationRomanNumeral.string(fromSymbols: symbols)
        }
    }

    // MARK: Private Static Interface

    private static func intValue(fromSymbols symbols: [RomanNumeralSymbol]) -> Int {
        return symbols.reduce(0) { $0 + $1.rawValue }
    }

    private static func symbols(fromIntValue intValue: Int) -> [RomanNumeralSymbol] {
        var remainingIntValue = intValue
        var convertedSymbols: [RomanNumeralSymbol] = []

        RomanNumeralSymbol.allSymbolsDescending.forEach { symbol in
            let symbolCount: Int = remainingIntValue / symbol.rawValue
            guard 0 < symbolCount else {
                return
            }

            let consecutiveSymbols = Array(repeating: symbol, count: symbolCount)
            convertedSymbols.append(contentsOf: consecutiveSymbols)
            remainingIntValue -= symbolCount * symbol.rawValue
        }

        return convertedSymbols
    }

}

// MARK: - RomanNumeralProtocol Extension

extension BasicNotationRomanNumeral: RomanNumeralProtocol {

    // MARK: Public Initialization

    public init(intValue: Int) throws {
        guard BasicNotationRomanNumeral.minimumIntValue <= intValue else {
            throw RomanNumeralError.valueLessThanMinimum
        }

        guard intValue <= BasicNotationRomanNumeral.maximumIntValue else {
            throw RomanNumeralError.valueGreaterThanMaximum
        }

        self.intValue = intValue

        symbols = BasicNotationRomanNumeral.symbols(fromIntValue: intValue)
        stringValue = BasicNotationRomanNumeral.string(fromSymbols: symbols)
    }

    public init(symbols: [RomanNumeralSymbol]) throws {
        let sanitizedSymbols = BasicRomanNumeralNotation.condense(symbols: symbols)

        try self.init(unsafeSymbols: sanitizedSymbols)
    }

    // MARK: Module Initialization

    init(unsafeSymbols: [RomanNumeralSymbol]) throws {
        symbols = unsafeSymbols

        intValue = BasicNotationRomanNumeral.intValue(fromSymbols: symbols)

        guard BasicNotationRomanNumeral.minimumIntValue <= intValue else {
            throw RomanNumeralError.valueLessThanMinimum
        }

        guard intValue <= BasicNotationRomanNumeral.maximumIntValue else {
            throw RomanNumeralError.valueGreaterThanMaximum
        }

        stringValue = BasicNotationRomanNumeral.string(fromSymbols: symbols)
    }

}

// MARK: - BasicNotationRomanNumeralSymbolsConvertible Extension

extension BasicNotationRomanNumeral: BasicNotationRomanNumeralConvertible {

    public var basicNotationRomanNumeral: BasicNotationRomanNumeral? {
        return self
    }

}

// MARK: - BasicNotationRomanNumeralSymbolsConvertible Extension

extension BasicNotationRomanNumeral: BasicNotationRomanNumeralSymbolsConvertible {

    public var basicNotationRomanNumeralSymbols: [RomanNumeralSymbol] {
        return symbols
    }

}

// MARK: - RomanNumeralConvertible Extension

extension BasicNotationRomanNumeral: RomanNumeralConvertible {

    public var romanNumeral: RomanNumeral? {
        return try? RomanNumeral(symbols: symbols)
    }

}

// MARK: - Operators Extension

extension BasicNotationRomanNumeral {

    //TODO: fix the places where I poorly avoid the intValue error by using minimum

    // MARK: Public Static Interface

    public static func + (
        left: BasicNotationRomanNumeral,
        right: BasicNotationRomanNumeral
        ) -> BasicNotationRomanNumeral {
        // Algorithm: http://turner.faculty.swau.edu/mathematics/materialslibrary/roman/

        let concatenatedSymbols = left.symbols + right.symbols
        let descendingConcatenatedSymbols = concatenatedSymbols.sorted(by: >)
        let condensedSymbols = BasicRomanNumeralNotation.condense(symbols: descendingConcatenatedSymbols)

        let romanNumeral: BasicNotationRomanNumeral
        do {
            romanNumeral = try BasicNotationRomanNumeral(symbols: condensedSymbols)
        } catch {
            switch error {
            case RomanNumeralError.valueLessThanMinimum:
                romanNumeral = .minimum
            case RomanNumeralError.valueGreaterThanMaximum:
                romanNumeral = .maximum
            default:
                romanNumeral = .minimum
            }
        }

        return romanNumeral
    }

    public static func - (
        left: BasicNotationRomanNumeral,
        right: BasicNotationRomanNumeral
        ) -> BasicNotationRomanNumeral {
        // Algorithm: http://turner.faculty.swau.edu/mathematics/materialslibrary/roman/

        let greaterSymbol = (left < right) ? right : left
        let lesserSymbol = (left < right) ? left : right
        let intResult = greaterSymbol.intValue - lesserSymbol.intValue

        return (try? BasicNotationRomanNumeral(intValue: intResult)) ?? .minimum
    }

}
