//
//  RomanNumeralError.swift
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

import Foundation

/**
 Errors related to Roman numerals.

 For errors specific to Roman numeral symbols please see `RomanNumeralSymbolError`.
 */
public enum RomanNumeralError: Error, CaseIterable {
    /// The given symbols for the Roman numeral are out-of-order for the notation.
    case symbolsOutOfOrder

    /// A Roman numeral's value cannot be greater than its notation's maximum value.
    case valueGreaterThanMaximum

    /// A Roman numeral's value cannot be less than its notation's minimum value.
    case valueLessThanMinimum
}

// MARK: - LocalizedError Extension

extension RomanNumeralError: LocalizedError {
    // MARK: Public Instance Interface

    public var errorDescription: String? {
        switch self {
        case .symbolsOutOfOrder:
            return "The given symbols for the Roman numeral are out-of-order for the notation."
        case .valueGreaterThanMaximum:
            return "A Roman numeral's value cannot be greater than its notation's maximum value."
        case .valueLessThanMinimum:
            return "A Roman numeral's value cannot be less than its notation's minimum value."
        }
    }
}
