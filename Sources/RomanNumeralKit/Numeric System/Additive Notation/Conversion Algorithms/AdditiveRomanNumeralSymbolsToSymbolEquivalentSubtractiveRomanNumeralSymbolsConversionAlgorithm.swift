//
//  AdditiveRomanNumeralSymbolsToSymbolEquivalentSubtractiveRomanNumeralSymbolsConversionAlgorithm.swift
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

public struct AdditiveRomanNumeralSymbolsToSymbolEquivalentSubtractiveRomanNumeralSymbolsConversionAlgorithm {
    // MARK: Private Initialization

    private init() {}
}

// MARK: - ConversionAlgorithm Extension

extension AdditiveRomanNumeralSymbolsToSymbolEquivalentSubtractiveRomanNumeralSymbolsConversionAlgorithm: UnfailableConversionAlgorithm {
    // MARK: Public Typealiases

    public typealias From = [RomanNumeralSymbol]
    public typealias To = [SubtractiveRomanNumeralSymbol]

    // MARK: Public Static Interface

    public static func convert(from: From) -> To {
        var lastProcessedIndex = -1

        return from
            .lazy
            .enumerated()
            .compactMap { index, additiveSymbol in
                guard lastProcessedIndex < index else {
                    return nil
                }

                let nextIndex = index + 1

                guard nextIndex < from.count else {
                    lastProcessedIndex = index

                    return additiveSymbol.subtractiveRomanNumeralSymbol
                }

                let nextAdditiveSymbol = from[nextIndex]

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
}
