//
//  Calendar+RomanNumeral.swift
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

extension Calendar {
    // MARK: Public Instance Interface

    /// The current year of the `Calendar` represented as a Roman numeral.
    public var currentYearAsRomanNumeral: RomanNumeral? {
        return yearAsRomanNumeral(fromDate: Date())
    }

    /**
     Returns the year of the given date as a Roman numeral.

     - Parameter date: The date whose year should be represented as a Roman numeral.
     - Returns: The year of the given date as a Roman numeral.
     */
    public func yearAsRomanNumeral(fromDate date: Date) -> RomanNumeral? {
        let dateComponents = self.dateComponents([.year], from: date)

        return dateComponents.yearAsRomanNumeral
    }
}
