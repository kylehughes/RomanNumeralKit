//
//  BasicRomanNumeralNotation.swift
//  RomanNumeralKit
//
//  Created by Kyle Hughes on 10/7/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation

struct BasicRomanNumeralNotation {

    // MARK: Initialization

    private init() {}

}

// MARK: - RomanNumeralNotationProtocol Extension

extension BasicRomanNumeralNotation: RomanNumeralNotationProtocol {

    public typealias RomanNumeralType = BasicNotationRomanNumeral

    // MARK: Public Static Properties

    public static var maximum: BasicNotationRomanNumeral {
        return BasicNotationRomanNumeral(unsafeSymbols: [.M, .M, .M, .D, .C, .C, .C, .C, .L, .X, .X, .X, .X, .V, .I, .I, .I, .I])
    }

    public static var minimum: BasicNotationRomanNumeral {
        return BasicNotationRomanNumeral(unsafeSymbols: [.I])
    }

    // MARK: Public Static Interface

    public static func condense(symbol: RomanNumeralSymbol, ofCount count: Int) -> [RomanNumeralSymbol] {
        let allSymbols = RomanNumeralSymbol.allSymbolsAscending

        guard let symbolIndex = allSymbols.firstIndex(of: symbol) else {
            return []
        }

        let nextHighestSymbolIndex = symbolIndex + 1

        guard nextHighestSymbolIndex < allSymbols.count else {
            return Array(repeating: symbol, count: count)
        }

        let nextHighestSymbol = allSymbols[nextHighestSymbolIndex]
        let nextHighestSymbolAsCurrentSymbols = nextHighestSymbol.expandedIntoLesserSymbol
        guard !nextHighestSymbolAsCurrentSymbols.isEmpty else {
            return []
        }
        let nextHighestSymbolQuantity = count / nextHighestSymbolAsCurrentSymbols.count
        let nextHighestSymbols = Array(repeating: nextHighestSymbol, count: nextHighestSymbolQuantity)
        let condensedNextHighestSymbols = BasicRomanNumeralNotation.condense(
            symbol: nextHighestSymbol,
            ofCount: nextHighestSymbols.count)

        let remainingSymbolQuanity = count % nextHighestSymbolAsCurrentSymbols.count
        let remainingSymbols = Array(repeating: symbol, count: remainingSymbolQuanity)

        return condensedNextHighestSymbols + remainingSymbols
    }

    public static func condense(symbols: [RomanNumeralSymbol]) -> [RomanNumeralSymbol] {
        let orderedSymbols: [RomanNumeralSymbol] = symbols
            .sorted(by: >)

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

}
