//
//  RomanNumeralSymbolDictionary.swift
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

public struct RomanNumeralSymbolDictionary<Value> {
    private var valueForI: Value
    private var valueForV: Value
    private var valueForX: Value
    private var valueForL: Value
    private var valueForC: Value
    private var valueForD: Value
    private var valueForM: Value

    private let defaultValue: Value

    // MARK: Public Initialization

    public init(defaultValue: Value) {
        self.defaultValue = defaultValue

        valueForI = defaultValue
        valueForV = defaultValue
        valueForX = defaultValue
        valueForL = defaultValue
        valueForC = defaultValue
        valueForD = defaultValue
        valueForM = defaultValue
    }

    // MARK: Public Subscript Interface

    public subscript(symbol: RomanNumeralSymbol) -> Value {
        get {
            getValue(forSymbol: symbol)
        }
        set {
            set(value: newValue, forSymbol: symbol)
        }
    }

    // MARK: Public Accessor Interface

    public func getValue(forSymbol symbol: RomanNumeralSymbol) -> Value {
        switch symbol {
        case .nulla:
            return defaultValue
        case .I:
            return valueForI
        case .V:
            return valueForV
        case .X:
            return valueForX
        case .L:
            return valueForL
        case .C:
            return valueForC
        case .D:
            return valueForD
        case .M:
            return valueForM
        }
    }

    public mutating func set(value: Value, forSymbol symbol: RomanNumeralSymbol) {
        switch symbol {
        case .nulla:
            break
        case .I:
            valueForI = value
        case .V:
            valueForV = value
        case .X:
            valueForX = value
        case .L:
            valueForL = value
        case .C:
            valueForC = value
        case .D:
            valueForD = value
        case .M:
            valueForM = value
        }
    }
}
