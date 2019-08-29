//
//  RomanNumeralProtocol.swift
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
 Roman numerals are a base-10 numeral system that originated in ancient Rome. They are traditionally composed of seven
 symbols with fixed integer values.

 Powers of ten - thousands, hundreds, tens, and units - are written separately from left to right.

 The rules for composing the symbols into Roman numerals, and the integer value represented by the Roman numerals,
 are a product of the notation used by the numeral. The most common notation used in modern times is subtractive
 notation (see `RomanNumeral`). A common alternative is additive notation (see `AdditiveRomanNumeral`).

 Conceptually, the Roman numeral is an abbreviation for the number of tally marks that are equal to the integer
 representation of the Roman numeral.

 See `RomanNumeralSymbolProtocol` and `RomanNumeralSymbol` for the definitions of the traditional symbols.

 - SeeAlso: https://en.wikipedia.org/wiki/Roman_numerals
 */
public protocol RomanNumeralProtocol: CustomDebugStringConvertible,
    CustomStringConvertible,
    ExpressibleByStringLiteral,
    Numeric,
    Strideable,
    RomanNumeralSymbolsConvertible {
    // MARK: Typealiases

    associatedtype Stride = Int

    // MARK: Initialization

    /**
     Creates a new Roman numeral represented by the value of the given symbols.

     The given symbols must be in the appropriate order for the type of notation.

     The given symbols will be condensed to the most succint representation using the fewest number of symbols. The
     symbols that are ultimately produced by the Roman numeral may not be the same symbols as the ones passed in, but
     the value will be equivalent.

     The value of the resulting Roman numeral must be within the `minimum` and `maximum` values for the type of
     notation.

     - Parameter symbols: The symbols to construct the Roman numeral from.
     */
    init(symbols: [RomanNumeralSymbol]) throws

    // MARK: Static Interface

    /// The maximum value that can be expressed by the implementing notation.
    static var maximum: Self { get }

    /// The minimum value that can be expressed by the implementing notation.
    static var minimum: Self { get }

    /**
     Condense the given symbols to their most succint representation using the fewest number of symbols.

     For example *VV* will be condensed to *X*.

     - Parameter symbols: The given symbols to condense.
     - Returns: The condensed form of the given symbols.
     */
    static func condense(symbols: [RomanNumeralSymbol]) -> [RomanNumeralSymbol]

    /**
     Convert the given symbols into their cumulative integer value for the implementing notation.

     The order of the symbols should follow the rules of the implementing notation.

     - Parameter symbols: The symbols that should be represented as a cumulative integer value.
     - Returns: The cumulative integer value of the given symbols.
     */
    static func int(from symbols: [RomanNumeralSymbol]) -> Int

    /**
     Convert the given integer into the corresponding symbols for the implementing notation.

     The returned symbols may not comprise a valid Roman numeral if the given integer value is not within the bounds
     defined by the implementing notation.

     - Parameter intValue: The integer to convert into a collection of symbols.
     - Returns: The symbolic representation of the given integer.
     */
    static func symbols(from intValue: Int) -> [RomanNumeralSymbol]

    // MARK: Instance Interface

    /// The symbols that compose the Roman numeral.
    var symbols: [RomanNumeralSymbol] { get }

    /// The group of tally marks that back the value of the Roman numeral.
    var tallyMarkGroup: RomanNumeralTallyMarkGroup { get }
}

// MARK: - Public Extension

public extension RomanNumeralProtocol {
    // MARK: Public Initialization

    /**
     Creates a new Roman numeral represented by the value of the given symbols.

     The given symbols must be in the appropriate order for the type of notation.

     The given symbols will be condensed to the most succint representation using the fewest number of symbols. The
     symbols that are ultimately produced by the Roman numeral may not be the same symbols as the ones passed in, but
     the value will be equivalent.

     The value of the resulting Roman numeral must be within the `minimum` and `maximum` values for the type of
     notation.

     - Parameter symbols: The symbols to construct the Roman numeral from.
     */
    init(_ symbols: RomanNumeralSymbol...) throws {
        try self.init(symbols: symbols)
    }

    /**
     Creates a new Roman numeral represented by the value of the given symbol.

     The value of the resulting Roman numeral must be within the `minimum` and `maximum` values for the type of
     notation.

     - Parameter symbol: The symbol to construct the Roman numeral from.
     */
    init(symbol: RomanNumeralSymbol) throws {
        try self.init(symbols: [symbol])
    }

    /**
     Creates a Roman numeral equivalent to the value of the given integer.

     The value of the resulting Roman numeral must be within the `minimum` and `maximum` values for the type of
     notation.

     - Parameter int: The integer value to construct an equivalent Roman numeral from.
     */
    init(from int: Int) throws {
        let symbols = Self.symbols(from: int)

        try self.init(symbols: symbols)
    }

    /**
     Creates a Roman numeral represented by the symbols found in the given string.

     The given symbols must be in the appropriate order for the type of notation.

     The given symbols will be condensed to the most succint representation using the fewest number of symbols. The
     symbols that are ultimately produced by the Roman numeral may not be the same symbols as the ones passed in, but
     the value will be equivalent.

     The value of the resulting Roman numeral must be within the `minimum` and `maximum` values for the type of
     notation.

     The string must exclusively be a valid Roman numeral with no extraneous characters.

     - Parameter string: The string representation of the symbols to construct the Roman numeral from.
     */
    init(from string: String) throws {
        let symbols = try Self.symbols(from: string)

        try self.init(symbols: symbols)
    }

    // MARK: Public Static Interface

    /**
     Convert the given symbols into their corresponding string representation.

     - Parameter symbols: The given symbol to concatenate into a single string.
     - Returns: The string representation of all of the given symbols.
     */
    static func string(from symbols: [RomanNumeralSymbol]) -> String {
        return symbols.reduce("") { $0.appending(String($1.stringValue)) }
    }

    /**
     Convert the given string into the corresponding collection of symbols.

     The string must only contain characters that are valid Roman numeral symbols.

     - Parameter string: The given string to convert into individual symbols.
     - Returns: The symbols that were represented by the given string.
     */
    static func symbols(from string: String) throws -> [RomanNumeralSymbol] {
        return try string
            .lazy
            .map { String($0) }
            .map { try RomanNumeralSymbol(from: $0) }
    }

    // MARK: Public Instance Interface

    /**
     The current Roman numeral formatted as a copyright declaration.

     For example: "Copyright © MMX"
     */
    var copyrightText: String {
        return "Copyright © \(stringValue)"
    }

    /// The current Roman numeral converted into its integer equivalent.
    var intValue: Int {
        return Self.int(from: symbols)
    }

    /// The current Roman numeral represented as a string.
    var stringValue: String {
        return Self.string(from: symbols)
    }
}

// MARK: - Comparable Extension

extension RomanNumeralProtocol {
    // MARK: Public Static Interface

    public static func < (lhs: Self, rhs: Self) -> Bool {
        guard lhs != rhs else {
            return false
        }

        return lhs.tallyMarkGroup < rhs.tallyMarkGroup
    }
}

// MARK: - CustomDebugStringConvertible Extension

extension RomanNumeralProtocol {
    // MARK: Public Instance Interface

    public var debugDescription: String {
        return stringValue
    }
}

// MARK: - CustomStringConvertible Extension

extension RomanNumeralProtocol {
    // MARK: Public Instance Interface

    public var description: String {
        return stringValue
    }
}

// MARK: - ExpressibleByIntegerLiteral Extension

extension RomanNumeralProtocol {
    // MARK: Public Initialization

    public init(integerLiteral: Int) {
        do {
            try self.init(from: integerLiteral)
        } catch {
            switch error {
            case RomanNumeralError.valueGreaterThanMaximum:
                self = Self.maximum
            default:
                self = Self.minimum
            }
        }
    }
}

// MARK: - ExpressibleByStringLiteral Extension

extension RomanNumeralProtocol {
    // MARK: Public Initialization

    public init(stringLiteral: String) {
        do {
            try self.init(from: stringLiteral)
        } catch {
            switch error {
            case RomanNumeralError.valueGreaterThanMaximum:
                self = Self.maximum
            default:
                self = Self.minimum
            }
        }
    }
}

// MARK: - Strideable Extension

extension RomanNumeralProtocol {
    // MARK: Public Instance Interface

    public func advanced(by n: Int) -> Self {
        return Self(integerLiteral: intValue + n)
    }

    public func distance(to other: Self) -> Int {
        return intValue - other.intValue
    }
}
