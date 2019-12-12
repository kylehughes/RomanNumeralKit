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

internal struct AdditiveRomanNumeralSymbolCondenser {
    private(set) var countForI: Int
    private(set) var countForV: Int
    private(set) var countForX: Int
    private(set) var countForL: Int
    private(set) var countForC: Int
    private(set) var countForD: Int
    private(set) var countForM: Int

    // MARK: Internal Initialization

    internal init() {
        countForI = 0
        countForV = 0
        countForX = 0
        countForL = 0
        countForC = 0
        countForD = 0
        countForM = 0
    }

    // MARK: Internal Instance Interface

    internal mutating func combine(symbols: [RomanNumeralSymbol]) {
        symbols.forEach { record(symbol: $0) }
    }

    internal mutating func finalize() -> [RomanNumeralSymbol] {
        RomanNumeralSymbol
            .allSymbolsAscending
            .forEach { condenseAndRecord(symbol: $0) }

        return RomanNumeralSymbol
            .allSymbolsDescending
            .map { ($0, getCount(forSymbol: $0)) }
            .map(Array.init)
            .reduce([], +)
    }

    // MARK: Private Static Interface

    private static func condense(symbol: RomanNumeralSymbol, ofCount count: Int) -> [RomanNumeralSymbol] {
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
        let nextHighestSymbolQuantity = count / nextHighestSymbolAsCurrentSymbols.count
        let nextHighestSymbols = Array(repeating: nextHighestSymbol, count: nextHighestSymbolQuantity)

        let remainingSymbolQuanity = count % nextHighestSymbolAsCurrentSymbols.count
        let remainingSymbols = Array(repeating: symbol, count: remainingSymbolQuanity)

        return nextHighestSymbols + remainingSymbols
    }

    // MARK: Private Instance Interface

    private mutating func clearRecord(forSymbol symbol: RomanNumeralSymbol) {
        switch symbol {
        case .nulla:
            break
        case .I:
            countForI = 0
        case .V:
            countForV = 0
        case .X:
            countForX = 0
        case .L:
            countForL = 0
        case .C:
            countForC = 0
        case .D:
            countForD = 0
        case .M:
            countForM = 0
        }
    }

    private mutating func condenseAndRecord(symbol: RomanNumeralSymbol) {
        let count = getCount(forSymbol: symbol)
        let condensedSymbols = Self.condense(symbol: symbol, ofCount: count)
        clearRecord(forSymbol: symbol)
        condensedSymbols.forEach { record(symbol: $0) }
    }

    private mutating func getCount(forSymbol symbol: RomanNumeralSymbol) -> Int {
        switch symbol {
        case .nulla:
            return 0
        case .I:
            return countForI
        case .V:
            return countForV
        case .X:
            return countForX
        case .L:
            return countForL
        case .C:
            return countForC
        case .D:
            return countForD
        case .M:
            return countForM
        }
    }

    private mutating func record(symbol: RomanNumeralSymbol) {
        switch symbol {
        case .nulla:
            break
        case .I:
            countForI += 1
        case .V:
            countForV += 1
        case .X:
            countForX += 1
        case .L:
            countForL += 1
        case .C:
            countForC += 1
        case .D:
            countForD += 1
        case .M:
            countForM += 1
        }
    }
}
