//
//  RomanNumeralSymbol.swift
//  RomanNumeralKit
//
//  Created by Kyle Hughes on 4/16/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation

// swiftlint:disable identifier_name

/**
 Roman numeral symbols are a collection of letters from the Latin alphabet that are used to represent numbers in the
 numeric system of ancient Rome. Roman numerals employ seven symbols, each with a fixed integer value. The number 0
 does not have its own Roman numeral symbol, but the word "nulla" (the Latin word meaning "none") is used in lieu of 0.
 */
public enum RomanNumeralSymbol: CaseIterable {

    case nulla
    case I
    case V
    case X
    case L
    case C
    case D
    case M

    // MARK: Public Static Properties

    /**
     All of the Roman numeral symbols, represented in ascending order by value.
     */
    public static let allSymbolsAscending: [RomanNumeralSymbol] = [.I, .V, .X, .L, .C, .D, .M]

    /**
     All of the Roman numeral symbols, represented in descending order by value.
     */
    public static let allSymbolsDescending: [RomanNumeralSymbol] = allSymbolsAscending.reversed()

    // MARK: Initialization

    public init(from characterValue: Character) throws {
        let potentialSymbol = RomanNumeralSymbol.allCases
            .filter { $0.characterValue == characterValue }
            .first

        guard let symbol = potentialSymbol else {
            throw RomanNumeralSymbolError.unrecognizedCharacter(character: characterValue)
        }

        self = symbol
    }

    // MARK: Public Instance Interface

    /**
     The `Character` representation of the the Latin letter representing the symbol.
     */
    public var characterValue: Character {
        switch self {
        case .nulla:
            return "N"
        case .I:
            return "I"
        case .V:
            return "V"
        case .X:
            return "X"
        case .L:
            return "L"
        case .C:
            return "C"
        case .D:
            return "D"
        case .M:
            return "M"
        }
    }

    public var expandedIntoLesserSymbol: [RomanNumeralSymbol] {
        switch self {
        case .nulla:
            return []
        case .I:
            return [.I]
        case .V:
            return [.I, .I, .I, .I, .I]
        case .X:
            return [.V, .V]
        case .L:
            return [.X, .X, .X, .X, .X]
        case .C:
            return [.L, .L]
        case .D:
            return [.C, .C, .C, .C, .C]
        case .M:
            return [.D, .D]
        }
    }

    public var lesserSymbol: RomanNumeralSymbol? {
        switch self {
        case .nulla:
            return nil
        case .I:
            return nil
        case .V:
            return .I
        case .X:
            return .V
        case .L:
            return .X
        case .C:
            return .L
        case .D:
            return .C
        case .M:
            return .D
        }
    }

}

// MARK: - RawRepresentable Extension

extension RomanNumeralSymbol: RawRepresentable {

    // MARK: Public Typealiases

    public typealias RawValue = RomanNumeralTallyMarkGroup

    // MARK: Public Initialization

    public init?(rawValue: RomanNumeralTallyMarkGroup) {
        switch rawValue.tallyMarks.count {
        case 0:
            self = .nulla
        case 1:
            self = .I
        case 5:
            self = .V
        case 10:
            self = .X
        case 50:
            self = .L
        case 100:
            self = .C
        case 500:
            self = .D
        case 1000:
            self = .M
        default:
            return nil
        }
    }

    // MARK: Public Interface

    public var rawValue: RomanNumeralTallyMarkGroup {
        switch self {
        case .nulla:
            return .nulla
        case .I:
            return RomanNumeralTallyMarkGroup(numberOfTallyMarks: 1)
        case .V:
            return RomanNumeralTallyMarkGroup(numberOfTallyMarks: 5)
        case .X:
            return RomanNumeralTallyMarkGroup(numberOfTallyMarks: 10)
        case .L:
            return RomanNumeralTallyMarkGroup(numberOfTallyMarks: 50)
        case .C:
            return RomanNumeralTallyMarkGroup(numberOfTallyMarks: 100)
        case .D:
            return RomanNumeralTallyMarkGroup(numberOfTallyMarks: 500)
        case .M:
            return RomanNumeralTallyMarkGroup(numberOfTallyMarks: 1000)
        }
    }

}

// MARK: - Comparable Extension

extension RomanNumeralSymbol: Comparable {

    public static func < (lhs: RomanNumeralSymbol, rhs: RomanNumeralSymbol) -> Bool {
        return lhs.rawValue.tallyMarks.count < rhs.rawValue.tallyMarks.count
    }

}

// MARK: - CustomStringConvertible Extension

extension RomanNumeralSymbol: CustomStringConvertible {

    public var description: String {
        return String(characterValue)
    }

}

// MARK: - CustomDebugStringConvertible Extension

extension RomanNumeralSymbol: CustomDebugStringConvertible {

    public var debugDescription: String {
        return description
    }

}
