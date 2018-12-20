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
 numeric system of ancient Rome. Roman numerals employ seven symbols, each with a fixed integer value.
 */
public enum RomanNumeralSymbol: Int {

    case I = 1
    case V = 5
    case X = 10
    case L = 50
    case C = 100
    case D = 500
    case M = 1000

    // MARK: Public Static Properties

    /**
     All of the Roman numeral symbols, represented in ascending order by integer value.
     */
    public static let allSymbolsAscending: [RomanNumeralSymbol] = [.I, .V, .X, .L, .C, .D, .M]

    /**
     All of the Roman numeral symbols, represented in descending order by integer value.
     */
    public static let allSymbolsDescending: [RomanNumeralSymbol] = allSymbolsAscending.reversed()

    // MARK: Public Properties

    /**
     The `Character` representation of the the Latin letter representing the symbol.
     */
    public var characterValue: Character {
        switch self {
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

    public var expanded: [RomanNumeralSymbol] {
        switch self {
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

    // MARK: Initialization

    public init(from characterValue: Character) throws {
        let potentialSymbol = RomanNumeralSymbol.allSymbolsAscending
            .filter { $0.characterValue == characterValue }
            .first

        guard let symbol = potentialSymbol else {
            throw RomanNumeralSymbolError.unrecognizedCharacter(character: characterValue)
        }

        self = symbol
    }

}

// MARK: - Comparable Extension

extension RomanNumeralSymbol: Comparable {

    public static func < (lhs: RomanNumeralSymbol, rhs: RomanNumeralSymbol) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }

}
