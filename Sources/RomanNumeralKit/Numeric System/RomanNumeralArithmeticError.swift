//
//  RomanNumeralArithmeticError.swift
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
 Errors related to Roman numerals arithmetic operations.
 */
public enum RomanNumeralArithmeticError: Error, CaseIterable {
    /// An unknown error occurred during the addition operation of two Roman numerals.
    case ambiguousAdditionError

    /// An unknown error occurred during the multiplication operation of two Roman numerals.
    case ambiguousMultiplicationError

    /// An unknown error occurred during the subtraction operation of two Roman numerals.
    case ambiguousSubtractionError

    /// Subtraction that will result in a negative value is not supported.
    case subtractionWhereRightValueIsGreaterThanLeftValue
}

// MARK: - LocalizedError Extension

extension RomanNumeralArithmeticError: LocalizedError {
    // MARK: Public Instance Interface

    public var errorDescription: String? {
        switch self {
        case .ambiguousAdditionError:
            return "An unknown error occurred during the addition operation of two Roman numerals."
        case .ambiguousMultiplicationError:
            return "An unknown error occurred during the multiplication operation of two Roman numerals."
        case .ambiguousSubtractionError:
            return "An unknown error occurred during the subtraction operation of two Roman numerals."
        case .subtractionWhereRightValueIsGreaterThanLeftValue:
            return "Subtraction that will result in a negative value is not supported."
        }
    }
}
