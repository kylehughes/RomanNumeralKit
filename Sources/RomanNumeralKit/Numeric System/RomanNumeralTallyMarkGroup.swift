//
//  RomanNumeralTallyMarkGroup.swift
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
 A collection of tally marks that serves as the backing value for a Roman numeral symbol.

 For example, `IIIII` contains five tally marks, so the value of the group is five.
 */
public struct RomanNumeralTallyMarkGroup: Codable, Equatable, Hashable {
    // MARK: Public Static Properties

    /// A tally mark group with 0 tally marks.
    public static let nulla = RomanNumeralTallyMarkGroup(numberOfTallyMarks: 0)

    /// A tally mark group with 1 tally mark.
    public static let one = RomanNumeralTallyMarkGroup(numberOfTallyMarks: 1)

    /// A tally mark group with 4 tally marks.
    public static let four = RomanNumeralTallyMarkGroup(numberOfTallyMarks: 4)

    /// A tally mark group with 5 tally marks.
    public static let five = RomanNumeralTallyMarkGroup(numberOfTallyMarks: 5)

    /// A tally mark group with 9 tally marks.
    public static let nine = RomanNumeralTallyMarkGroup(numberOfTallyMarks: 9)

    /// A tally mark group with 10 tally marks.
    public static let ten = RomanNumeralTallyMarkGroup(numberOfTallyMarks: 10)

    /// A tally mark group with 40 tally marks.
    public static let forty = RomanNumeralTallyMarkGroup(numberOfTallyMarks: 40)

    /// A tally mark group with 50 tally marks.
    public static let fifty = RomanNumeralTallyMarkGroup(numberOfTallyMarks: 50)

    /// A tally mark group with 90 tally marks.
    public static let ninety = RomanNumeralTallyMarkGroup(numberOfTallyMarks: 90)

    /// A tally mark group with 100 tally marks.
    public static let oneHundred = RomanNumeralTallyMarkGroup(numberOfTallyMarks: 100)

    /// A tally mark group with 400 tally marks.
    public static let fourHundred = RomanNumeralTallyMarkGroup(numberOfTallyMarks: 400)

    /// A tally mark group with 500 tally marks.
    public static let fiveHundred = RomanNumeralTallyMarkGroup(numberOfTallyMarks: 500)

    /// A tally mark group with 900 tally marks.
    public static let nineHundred = RomanNumeralTallyMarkGroup(numberOfTallyMarks: 900)

    /// A tally mark group with 1000 tally marks.
    public static let oneThousand = RomanNumeralTallyMarkGroup(numberOfTallyMarks: 1000)

    // MARK: Public Instance Properties

    /// The tally marks that are in the group. The number of tally marks represents the value of the group.
    public let tallyMarks: [RomanNumeralTallyMark]

    // MARK: Public Initialization

    /**
     Creates a tally mark group that contains the given number of tally marks.

     - Parameter numberOfTallyMarks: The number of tally marks in the group.
     */
    public init(numberOfTallyMarks: Int) {
        tallyMarks = Array(repeating: RomanNumeralTallyMark(), count: numberOfTallyMarks)
    }

    /**
     Creates a tally mark group that contains the given tally marks.

     - Parameter tallyMarks: The tally marks in the group.
     */
    public init(tallyMarks: [RomanNumeralTallyMark]) {
        self.tallyMarks = tallyMarks
    }
}

// MARK: - Operators Extension

extension RomanNumeralTallyMarkGroup {
    // MARK: Public Static Interface

    public static func + (
        left: RomanNumeralTallyMarkGroup,
        right: RomanNumeralTallyMarkGroup
    ) -> RomanNumeralTallyMarkGroup {
        RomanNumeralTallyMarkGroup(tallyMarks: left.tallyMarks + right.tallyMarks)
    }
}

// MARK: - Comparable Extension

extension RomanNumeralTallyMarkGroup: Comparable {
    // MARK: Public Static Interface

    public static func < (lhs: RomanNumeralTallyMarkGroup, rhs: RomanNumeralTallyMarkGroup) -> Bool {
        lhs.tallyMarks.count < rhs.tallyMarks.count
    }
}

// MARK: - CustomDebugStringConvertible Extension

extension RomanNumeralTallyMarkGroup: CustomDebugStringConvertible {
    public var debugDescription: String {
        tallyMarks.map { $0.debugDescription }.joined()
    }
}

// MARK: - CustomStringConvertible Extension

extension RomanNumeralTallyMarkGroup: CustomStringConvertible {
    public var description: String {
        tallyMarks.map { $0.description }.joined()
    }
}

// MARK: - Sequence Extension

extension RomanNumeralTallyMarkGroup: Sequence {
    // MARK: Public Typealiases

    public typealias Iterator = IndexingIterator<[RomanNumeralTallyMark]>

    // MARK: Public Instance Interface

    public func makeIterator() -> IndexingIterator<[RomanNumeralTallyMark]> {
        tallyMarks.makeIterator()
    }
}
