//
//  RomanNumeralNotationProtocol.swift
//  RomanNumeralKit
//
//  Created by Kyle Hughes on 10/7/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation

/**
 A Roman numeral notation is a method of representing or encoding numbers expressed by Roman numeral symbols in the
 numeric system of ancient Rome.
 */
public protocol RomanNumeralNotationProtocol {

    associatedtype RomanNumeralType: RomanNumeralProtocol

    // MARK: Static Properties

    /**
     The maximum value that can be expressed with this notation.
     */
    static var maximum: RomanNumeralType { get }

    /**
     The minimum value that can be expressed with this notation.
     */
    static var minimum: RomanNumeralType { get }

    // MARK: Static Interface

    // TODO: Throw errors from these functions

    static func condense(symbol: RomanNumeralSymbol, ofCount count: Int) -> [RomanNumeralSymbol]
    static func condense(symbols: [RomanNumeralSymbol]) -> [RomanNumeralSymbol]

}

// MARK: - Public Extension

extension RomanNumeralNotationProtocol {

    public static func clamp(value: RomanNumeralType) -> RomanNumeralType {
        let clampedValue: RomanNumeralType

        if value < minimum {
            clampedValue = minimum
        } else if maximum < value {
            clampedValue = maximum
        } else {
            clampedValue = value
        }

        return clampedValue
    }

}
