//
//  RomanNumeralTallyMarkGroupTests.swift
//  RomanNumeralKitTests
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

import XCTest

@testable import RomanNumeralKit

class RomanNumeralTallyMarkGroupTests: XCTestCase {
    // MARK: XCTestCase Implementation

    override func setUp() {}

    override func tearDown() {}

    // MARK: Tests

    func test_init_numberOfTallyMarks() {
        XCTAssertEqual(RomanNumeralTallyMarkGroup(numberOfTallyMarks: 0).tallyMarks.count, 0)
        XCTAssertEqual(RomanNumeralTallyMarkGroup(numberOfTallyMarks: 1).tallyMarks.count, 1)
        XCTAssertEqual(RomanNumeralTallyMarkGroup(numberOfTallyMarks: 4).tallyMarks.count, 4)
        XCTAssertEqual(RomanNumeralTallyMarkGroup(numberOfTallyMarks: 5).tallyMarks.count, 5)
        XCTAssertEqual(RomanNumeralTallyMarkGroup(numberOfTallyMarks: 9).tallyMarks.count, 9)
        XCTAssertEqual(RomanNumeralTallyMarkGroup(numberOfTallyMarks: 10).tallyMarks.count, 10)
        XCTAssertEqual(RomanNumeralTallyMarkGroup(numberOfTallyMarks: 40).tallyMarks.count, 40)
        XCTAssertEqual(RomanNumeralTallyMarkGroup(numberOfTallyMarks: 50).tallyMarks.count, 50)
        XCTAssertEqual(RomanNumeralTallyMarkGroup(numberOfTallyMarks: 90).tallyMarks.count, 90)
        XCTAssertEqual(RomanNumeralTallyMarkGroup(numberOfTallyMarks: 100).tallyMarks.count, 100)
        XCTAssertEqual(RomanNumeralTallyMarkGroup(numberOfTallyMarks: 400).tallyMarks.count, 400)
        XCTAssertEqual(RomanNumeralTallyMarkGroup(numberOfTallyMarks: 500).tallyMarks.count, 500)
        XCTAssertEqual(RomanNumeralTallyMarkGroup(numberOfTallyMarks: 900).tallyMarks.count, 900)
        XCTAssertEqual(RomanNumeralTallyMarkGroup(numberOfTallyMarks: 1000).tallyMarks.count, 1000)
    }

    func test_init_tallyMarks() {
        // Given...

        let I = RomanNumeralTallyMark()

        // Then...

        XCTAssertEqual(RomanNumeralTallyMarkGroup(tallyMarks: [I]).tallyMarks, [I])
        XCTAssertEqual(RomanNumeralTallyMarkGroup(tallyMarks: [I, I, I, I, I]).tallyMarks, [I, I, I, I, I])
    }
}

// MARK: - Comparable Tests

extension RomanNumeralTallyMarkGroupTests {
    func test_lessThan() {
        XCTAssert(RomanNumeralTallyMarkGroup.one < RomanNumeralTallyMarkGroup.four)
        XCTAssert(RomanNumeralTallyMarkGroup.four < RomanNumeralTallyMarkGroup.five)
        XCTAssert(RomanNumeralTallyMarkGroup.five < RomanNumeralTallyMarkGroup.nine)
        XCTAssert(RomanNumeralTallyMarkGroup.nine < RomanNumeralTallyMarkGroup.ten)
        XCTAssert(RomanNumeralTallyMarkGroup.ten < RomanNumeralTallyMarkGroup.forty)
        XCTAssert(RomanNumeralTallyMarkGroup.forty < RomanNumeralTallyMarkGroup.fifty)
        XCTAssert(RomanNumeralTallyMarkGroup.fifty < RomanNumeralTallyMarkGroup.ninety)
        XCTAssert(RomanNumeralTallyMarkGroup.ninety < RomanNumeralTallyMarkGroup.oneHundred)
        XCTAssert(RomanNumeralTallyMarkGroup.oneHundred < RomanNumeralTallyMarkGroup.fourHundred)
        XCTAssert(RomanNumeralTallyMarkGroup.fourHundred < RomanNumeralTallyMarkGroup.fiveHundred)
        XCTAssert(RomanNumeralTallyMarkGroup.fiveHundred < RomanNumeralTallyMarkGroup.nineHundred)
        XCTAssert(RomanNumeralTallyMarkGroup.nineHundred < RomanNumeralTallyMarkGroup.oneThousand)

        XCTAssertFalse(RomanNumeralTallyMarkGroup.four < RomanNumeralTallyMarkGroup.one)
        XCTAssertFalse(RomanNumeralTallyMarkGroup.five < RomanNumeralTallyMarkGroup.four)
        XCTAssertFalse(RomanNumeralTallyMarkGroup.nine < RomanNumeralTallyMarkGroup.five)
        XCTAssertFalse(RomanNumeralTallyMarkGroup.ten < RomanNumeralTallyMarkGroup.nine)
        XCTAssertFalse(RomanNumeralTallyMarkGroup.forty < RomanNumeralTallyMarkGroup.ten)
        XCTAssertFalse(RomanNumeralTallyMarkGroup.fifty < RomanNumeralTallyMarkGroup.forty)
        XCTAssertFalse(RomanNumeralTallyMarkGroup.ninety < RomanNumeralTallyMarkGroup.fifty)
        XCTAssertFalse(RomanNumeralTallyMarkGroup.oneHundred < RomanNumeralTallyMarkGroup.ninety)
        XCTAssertFalse(RomanNumeralTallyMarkGroup.fourHundred < RomanNumeralTallyMarkGroup.oneHundred)
        XCTAssertFalse(RomanNumeralTallyMarkGroup.fiveHundred < RomanNumeralTallyMarkGroup.fourHundred)
        XCTAssertFalse(RomanNumeralTallyMarkGroup.nineHundred < RomanNumeralTallyMarkGroup.fiveHundred)
        XCTAssertFalse(RomanNumeralTallyMarkGroup.oneThousand < RomanNumeralTallyMarkGroup.nineHundred)

        XCTAssertFalse(RomanNumeralTallyMarkGroup.one < RomanNumeralTallyMarkGroup.one)
        XCTAssertFalse(RomanNumeralTallyMarkGroup.four < RomanNumeralTallyMarkGroup.four)
        XCTAssertFalse(RomanNumeralTallyMarkGroup.five < RomanNumeralTallyMarkGroup.five)
        XCTAssertFalse(RomanNumeralTallyMarkGroup.nine < RomanNumeralTallyMarkGroup.nine)
        XCTAssertFalse(RomanNumeralTallyMarkGroup.ten < RomanNumeralTallyMarkGroup.ten)
        XCTAssertFalse(RomanNumeralTallyMarkGroup.forty < RomanNumeralTallyMarkGroup.forty)
        XCTAssertFalse(RomanNumeralTallyMarkGroup.fifty < RomanNumeralTallyMarkGroup.fifty)
        XCTAssertFalse(RomanNumeralTallyMarkGroup.ninety < RomanNumeralTallyMarkGroup.ninety)
        XCTAssertFalse(RomanNumeralTallyMarkGroup.oneHundred < RomanNumeralTallyMarkGroup.oneHundred)
        XCTAssertFalse(RomanNumeralTallyMarkGroup.fourHundred < RomanNumeralTallyMarkGroup.fourHundred)
        XCTAssertFalse(RomanNumeralTallyMarkGroup.fiveHundred < RomanNumeralTallyMarkGroup.fiveHundred)
        XCTAssertFalse(RomanNumeralTallyMarkGroup.nineHundred < RomanNumeralTallyMarkGroup.nineHundred)
        XCTAssertFalse(RomanNumeralTallyMarkGroup.oneThousand < RomanNumeralTallyMarkGroup.oneThousand)
    }
}

// MARK: - CustomDebugStringConvertible Tests

extension RomanNumeralTallyMarkGroupTests {
    func test_customDebugStringConvertible() {
        XCTAssertEqual(
            RomanNumeralTallyMarkGroup.oneHundred.debugDescription,
            RomanNumeralTallyMarkGroup.oneHundred.tallyMarks.map { $0.debugDescription }.joined()
        )
    }
}

// MARK: - CustomStringConvertible Tests

extension RomanNumeralTallyMarkGroupTests {
    func test_customStringConvertible() {
        XCTAssertEqual(
            RomanNumeralTallyMarkGroup.oneHundred.description,
            RomanNumeralTallyMarkGroup.oneHundred.tallyMarks.map { $0.description }.joined()
        )
    }
}

// MARK: - Operators Tests

extension RomanNumeralTallyMarkGroupTests {
    func test_addition() {
        XCTAssertEqual(
            RomanNumeralTallyMarkGroup.one + RomanNumeralTallyMarkGroup.one,
            RomanNumeralTallyMarkGroup(numberOfTallyMarks: 2)
        )
        XCTAssertEqual(
            RomanNumeralTallyMarkGroup.fifty + RomanNumeralTallyMarkGroup.oneHundred,
            RomanNumeralTallyMarkGroup(numberOfTallyMarks: 150)
        )
        XCTAssertEqual(
            RomanNumeralTallyMarkGroup.oneThousand + RomanNumeralTallyMarkGroup.nineHundred,
            RomanNumeralTallyMarkGroup(numberOfTallyMarks: 1900)
        )
    }
}

// MARK: - Sequence Tests

extension RomanNumeralTallyMarkGroupTests {
    func test_makeIterator() {
        // Given...

        let tallyMarkGroup = RomanNumeralTallyMarkGroup.oneHundred

        // When...

        var iterator = tallyMarkGroup.makeIterator()

        var numberOfIterations = 0
        while let _ = iterator.next() {
            numberOfIterations += 1
        }

        // Then...

        XCTAssertEqual(numberOfIterations, tallyMarkGroup.tallyMarks.count)
    }
}
