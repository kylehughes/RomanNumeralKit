//
//  RomanNumeralTallyMark.swift
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
 A tally mark used for counting.

 This is the atomic component that backs the value of each Roman numeral symbol. Tally marks are typically counted in
 groups (see `RomanNumeralTallyMarkGroup`).

 The tally mark should not be confused with the Roman numeral symbol `I`, although both share the same numeric value.
 The tally mark is represented using the ASCII "vertical bar" character.

 - SeeAlso: https://theasciicode.com.ar/ascii-printable-characters/vertical-bar-vbar-vertical-line-vertical-slash-ascii-code-124.html
 */
public struct RomanNumeralTallyMark: Equatable {
    // MARK: Public Initialization

    /**
     Creates a tally mark.
     */
    public init() {}
}

// MARK: - CustomStringConvertible Extension

extension RomanNumeralTallyMark: CustomStringConvertible {
    // MARK: Public Instance Interface

    public var description: String {
        "|"
    }
}

// MARK: - CustomDebugStringConvertible Extension

extension RomanNumeralTallyMark: CustomDebugStringConvertible {
    // MARK: Public Instance Interface

    public var debugDescription: String {
        description
    }
}
