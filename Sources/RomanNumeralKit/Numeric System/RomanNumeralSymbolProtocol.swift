//
//  RomanNumeralSymbolProtocol.swift
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

/**
 Roman numeral symbols are a collection of letters from the Latin alphabet that are used to represent numbers in the
 numeric system of ancient Rome. Each symbol is shorthand for a specific number of tally marks.

 The backing values of the Roman numeral symbols, as found in their `rawValue`, are `RomanNumeralTallyMarkGroups` which
 are used to collect all of the corresponding `RomanNumeralTallyMark`s. Any representations of the symbols as Western
 Arabic numerals (e.g. `Int`) are conversions made by counting these tally marks.
 */
public protocol RomanNumeralSymbolProtocol: Comparable,
    CustomStringConvertible,
    CustomDebugStringConvertible,
    Hashable,
    RawRepresentable where RawValue == RomanNumeralTallyMarkGroup {
    // MARK: Initialization

    /**
     Creates a Roman numeral symbol from a `String` value if there is a corresponding symbol for the `String`.

     - Parameter stringValue: The string representation of the desired Roman numeral symbol.
     - Throws: `RomanNumeralSymbolError.unrecognizedString` if the given string does not match a known Roman
     numeral symbol.
     */
    init(from stringValue: String) throws

    // MARK: Static Interface

    /// All of the Roman numeral symbols, represented in ascending order by value.
    static var allSymbolsAscending: [Self] { get }

    /// All of the Roman numeral symbols, represented in descending order by value.
    static var allSymbolsDescending: [Self] { get }

    // MARK: Instance Interface

    /**
     The Roman numeral symbol whose value is next-highest.

     For example, `V` is the greater symbol than `I`, but `V` is not the greater symbol compared to `X`.

     - Note:`M` will return `nil`.
     */
    var greaterSymbol: Self? { get }

    /**
     The Roman numeral symbol whose value is next-lowest.

     For example, `V` is the lesser symbol to `X`, but `V` is not the lesser symbol to `L`.

     - Note: Both `I` and `nulla` will return `nil` because 0 is technically not a recognized value.
     */
    var lesserSymbol: Self? { get }

    /// The `String` representation of the Roman numeral symbol.
    var stringValue: String { get }
}

// MARK: - Comparable Extension

extension RomanNumeralSymbolProtocol {
    // MARK: Public Static Interface

    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue.tallyMarks.count < rhs.rawValue.tallyMarks.count
    }
}

// MARK: - CustomDebugStringConvertible Extension

extension RomanNumeralSymbolProtocol {
    // MARK: Public Instance Interface

    public var debugDescription: String {
        String(stringValue)
    }
}

// MARK: - CustomStringConvertible Extension

extension RomanNumeralSymbolProtocol {
    // MARK: Public Instance Interface

    public var description: String {
        String(stringValue)
    }
}
