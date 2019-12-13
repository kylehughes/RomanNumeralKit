//
//  AdditiveRomanNumeralSymbolCalculator.swift
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

public struct AdditiveRomanNumeralSymbolCalculator {
    public private(set) var value: Int

    private var storage: RomanNumeralSymbolDictionary<Int>

    // MARK: Public Initialization

    public init() {
        storage = RomanNumeralSymbolDictionary(defaultValue: 0)
        value = 0
    }
}

extension AdditiveRomanNumeralSymbolCalculator: RomanNumeralSymbolCalculator {
    // MARK: Public Instance Interface

    public mutating func add(symbol: RomanNumeralSymbol) {
        // The balance we strike for optimization vs spirit of the framework is that we "remember" how many tally marks
        // each symbol represents once we count it once.
        let numberOfTallyMarksForSymbol: Int = {
            let count = storage[symbol]

            guard count > 0 else {
                let learnedCount = symbol.rawValue.tallyMarks.count
                storage[symbol] = learnedCount
                return learnedCount
            }

            return count
        }()

        value += numberOfTallyMarksForSymbol
    }
}
