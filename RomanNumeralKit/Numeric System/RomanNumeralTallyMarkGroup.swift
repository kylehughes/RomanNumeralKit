//
//  RomanNumeralTallyMarkGroup.swift
//  RomanNumeralKit
//
//  Created by Kyle Hughes on 6/12/19.
//  Copyright © 2019 Kyle Hughes. All rights reserved.
//

import Foundation

public struct RomanNumeralTallyMarkGroup: Equatable {

    // MARK: Public Static Properties

    public static let nulla = RomanNumeralTallyMarkGroup(tallyMarks: [])

    // MARK: Public Instance Properties

    public let tallyMarks: [RomanNumeralTallyMark]

    // MARK: Public Initialization

    public init(numberOfTallyMarks: Int) {
        tallyMarks = Array(repeating: RomanNumeralTallyMark(), count: numberOfTallyMarks)
    }

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

        return RomanNumeralTallyMarkGroup(tallyMarks: left.tallyMarks + right.tallyMarks)
    }

}

// MARK: - Comparable Extension

extension RomanNumeralTallyMarkGroup: Comparable {

    // MARK: Public Static Interface

    public static func < (lhs: RomanNumeralTallyMarkGroup, rhs: RomanNumeralTallyMarkGroup) -> Bool {
        return lhs.tallyMarks.count < rhs.tallyMarks.count
    }

}

// MARK: - Sequence Extension

extension RomanNumeralTallyMarkGroup: Sequence {

    // MARK: Public Typealiases

    public typealias Iterator = IndexingIterator<[RomanNumeralTallyMark]>

    // MARK: Public Instance Interface

    public func makeIterator() -> IndexingIterator<[RomanNumeralTallyMark]> {
        return tallyMarks.makeIterator()
    }

}

// MARK: - CustomStringConvertible Extension

extension RomanNumeralTallyMarkGroup: CustomStringConvertible {

    public var description: String {
        return tallyMarks.map { $0.description }.joined()
    }

}

// MARK: - CustomDebugStringConvertible Extension

extension RomanNumeralTallyMarkGroup: CustomDebugStringConvertible {

    public var debugDescription: String {
        return tallyMarks.map { $0.debugDescription }.joined()
    }

}
