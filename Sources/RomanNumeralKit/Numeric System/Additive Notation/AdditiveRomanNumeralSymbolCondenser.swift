//
//  AdditiveRomanNumeralSymbolCondenser.swift
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

public struct AdditiveRomanNumeralSymbolCondenser {
    private var storage: RomanNumeralSymbolDictionary<Int>

    // MARK: Public Initialization

    public init() {
        storage = RomanNumeralSymbolDictionary(defaultValue: 0)
    }

    // MARK: Private Static Interface

    private static func condense(symbol: RomanNumeralSymbol, ofCount count: Int) -> [RomanNumeralSymbol] {
        guard let nextGreatestSymbol = symbol.greaterSymbol else {
            return Array(repeating: symbol, count: count)
        }

        let nextGreatestSymbolAsCurrentSymbols = nextGreatestSymbol.expandedIntoLesserSymbol
        let nextGreatestSymbolQuantity = count / nextGreatestSymbolAsCurrentSymbols.count
        let nextGreatestSymbols = Array(repeating: nextGreatestSymbol, count: nextGreatestSymbolQuantity)

        let remainingSymbolQuanity = count % nextGreatestSymbolAsCurrentSymbols.count
        let remainingSymbols = Array(repeating: symbol, count: remainingSymbolQuanity)

        return nextGreatestSymbols + remainingSymbols
    }

    // MARK: Private Instance Interface

    private mutating func condenseAndRecord(symbol: RomanNumeralSymbol) {
        let count = storage[symbol]
        let condensedSymbols = Self.condense(symbol: symbol, ofCount: count)
        storage[symbol] = 0
        condensedSymbols.forEach { record(symbol: $0) }
    }

    private mutating func record(symbol: RomanNumeralSymbol) {
        storage[symbol] += 1
    }
}

// MARK: - RomanNumeralSymbolCondenser Extension

extension AdditiveRomanNumeralSymbolCondenser: RomanNumeralSymbolCondenser {
    // MARK: Internal Instance Interface

    public mutating func combine(symbols: [RomanNumeralSymbol]) {
        symbols.forEach { record(symbol: $0) }
    }

    public mutating func finalize() -> [RomanNumeralSymbol] {
        RomanNumeralSymbol
            .allSymbolsAscending
            .forEach { condenseAndRecord(symbol: $0) }

        return RomanNumeralSymbol
            .allSymbolsDescending
            .map { Array(repeating: $0, count: storage[$0]) }
            .reduce([], +)
    }
}
