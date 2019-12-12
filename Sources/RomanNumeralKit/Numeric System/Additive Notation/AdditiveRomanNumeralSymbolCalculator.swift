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

    private var numberOfTallyMarksForI: Int
    private var numberOfTallyMarksForV: Int
    private var numberOfTallyMarksForX: Int
    private var numberOfTallyMarksForL: Int
    private var numberOfTallyMarksForC: Int
    private var numberOfTallyMarksForD: Int
    private var numberOfTallyMarksForM: Int

    // MARK: Public Initialization

    public init() {
        // The balance we strike for optimization vs spirit of the framework is that we "remember" how many tally marks
        // each symbol represents once we count it once.
        numberOfTallyMarksForI = 0
        numberOfTallyMarksForV = 0
        numberOfTallyMarksForX = 0
        numberOfTallyMarksForL = 0
        numberOfTallyMarksForC = 0
        numberOfTallyMarksForD = 0
        numberOfTallyMarksForM = 0
        value = 0
    }
}

extension AdditiveRomanNumeralSymbolCalculator: RomanNumeralSymbolCalculator {
    // MARK: Public Instance Interface

    public mutating func add(symbol: RomanNumeralSymbol) {
        switch symbol {
        case .nulla:
            break
        case .I:
            if numberOfTallyMarksForI == 0 {
                numberOfTallyMarksForI = RomanNumeralSymbol.I.rawValue.tallyMarks.count
            }
            value += numberOfTallyMarksForI
        case .V:
            if numberOfTallyMarksForV == 0 {
                numberOfTallyMarksForV = RomanNumeralSymbol.V.rawValue.tallyMarks.count
            }
            value += numberOfTallyMarksForV
        case .X:
            if numberOfTallyMarksForX == 0 {
                numberOfTallyMarksForX = RomanNumeralSymbol.X.rawValue.tallyMarks.count
            }
            value += numberOfTallyMarksForX
        case .L:
            if numberOfTallyMarksForL == 0 {
                numberOfTallyMarksForL = RomanNumeralSymbol.L.rawValue.tallyMarks.count
            }
            value += numberOfTallyMarksForL
        case .C:
            if numberOfTallyMarksForC == 0 {
                numberOfTallyMarksForC = RomanNumeralSymbol.C.rawValue.tallyMarks.count
            }
            value += numberOfTallyMarksForC
        case .D:
            if numberOfTallyMarksForD == 0 {
                numberOfTallyMarksForD = RomanNumeralSymbol.D.rawValue.tallyMarks.count
            }
            value += numberOfTallyMarksForD
        case .M:
            if numberOfTallyMarksForM == 0 {
                numberOfTallyMarksForM = RomanNumeralSymbol.M.rawValue.tallyMarks.count
            }
            value += numberOfTallyMarksForM
        }
    }
}
