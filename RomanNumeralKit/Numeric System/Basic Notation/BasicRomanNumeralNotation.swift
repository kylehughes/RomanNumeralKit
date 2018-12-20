//
//  BasicRomanNumeralNotation.swift
//  RomanNumeralKit
//
//  Created by Kyle Hughes on 10/7/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation

// swiftlint:disable force_try

struct BasicRomanNumeralNotation {

    // MARK: Initialization

    private init() {}

}

// MARK: - RomanNumeralNotationProtocol Extension

extension BasicRomanNumeralNotation: RomanNumeralNotationProtocol {

    public typealias RomanNumeralType = BasicNotationRomanNumeral

    // MARK: Public Static Properties

    public static var maximum: BasicNotationRomanNumeral {
        return try! BasicNotationRomanNumeral(unsafeSymbols: [.M, .M, .M, .C, .M, .X, .C, .I, .X])
    }

    public static var minimum: BasicNotationRomanNumeral {
        return try! BasicNotationRomanNumeral(unsafeSymbols: [.I])
    }

    // MARK: Public Static Interface

    public static func condense(symbols: [RomanNumeralSymbol]) -> [RomanNumeralSymbol] {
        let orderedSymbols: [RomanNumeralSymbol] = symbols
            .sorted()
            .reversed()

        // TODO: Fix this deviation on the algo, should go RTL, no filtering just track range. This is inefficient.
        var condensedSymbols = orderedSymbols
        for currentSymbol in RomanNumeralSymbol.allSymbolsAscending {
            guard
                let startIndexOfSymbol = condensedSymbols.firstIndex(of: currentSymbol),
                let endIndexOfSymbol = condensedSymbols.lastIndex(of: currentSymbol)
                else {
                    continue
            }

            let currentSymbols = condensedSymbols.filter { $0 == currentSymbol }
            let currentCondensedSymbols = BasicRomanNumeralNotation.condense(
                symbol: currentSymbol,
                ofCount: currentSymbols.count)

            condensedSymbols.replaceSubrange(startIndexOfSymbol...endIndexOfSymbol, with: currentCondensedSymbols)
        }

        return condensedSymbols
    }

    public static func condense(symbol: RomanNumeralSymbol, ofCount count: Int) -> [RomanNumeralSymbol] {
        let allSymbols = RomanNumeralSymbol.allSymbolsAscending

        guard let symbolIndex = allSymbols.firstIndex(of: symbol) else {
            return []
        }

        let nextHighestSymbolIndex = symbolIndex + 1

        guard nextHighestSymbolIndex < allSymbols.count else {
            return Array(repeating: symbol, count: count)
        }

        //TODO: Somehow avoid referencing intValue/rawValue?
        let nextHighestSymbol = allSymbols[nextHighestSymbolIndex]
        let totalSymbolValue = symbol.rawValue * count
        let nextHighestSymbolQuantity = totalSymbolValue / nextHighestSymbol.rawValue
        let totalNextHighestSymbolValue = nextHighestSymbol.rawValue * nextHighestSymbolQuantity
        let remainingSymbolValue = totalSymbolValue - totalNextHighestSymbolValue
        let remainingSymbolQuanity = remainingSymbolValue / symbol.rawValue
        let nextHighestSymbols = Array(repeating: nextHighestSymbol, count: nextHighestSymbolQuantity)
        let remainingSymbols = Array(repeating: symbol, count: remainingSymbolQuanity)

        return nextHighestSymbols + remainingSymbols
    }

}
