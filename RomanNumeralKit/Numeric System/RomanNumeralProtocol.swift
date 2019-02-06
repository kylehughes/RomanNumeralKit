//
//  RomanNumeralProtocol.swift
//  RomanNumeralKit
//
//  Created by Kyle Hughes on 9/30/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation
import os

// swiftlint:disable force_try

public protocol RomanNumeralProtocol: Comparable,
    CustomDebugStringConvertible,
    CustomStringConvertible,
    ExpressibleByIntegerLiteral,
ExpressibleByStringLiteral {

    // MARK: Static Properties

    static var maximumIntValue: Int { get }
    static var minimumIntValue: Int { get }

    // MARK: Properties

    var intValue: Int { get }
    var stringValue: String { get }
    var symbols: [RomanNumeralSymbol] { get }

    // MARK: Initialization

    init(intValue: Int) throws
    init(symbols: [RomanNumeralSymbol]) throws

}

// MARK: - Public Extension

public extension RomanNumeralProtocol {

    // MARK: Public Static Properties

    public static var maximum: Self {
        return try! Self(intValue: maximumIntValue)
    }

    public static var minimum: Self {
        return try! Self(intValue: minimumIntValue)
    }

    // MARK: Public Computed Properties

    public var copyrightText: String {
        return "Copyright © \(stringValue)"
    }

    // MARK: Public Initialization

    public init(symbol: RomanNumeralSymbol) throws {
        try self.init(symbols: [symbol])
    }

    public init(from string: String) throws {
        let symbols = try Self.symbols(fromString: string)
        try self.init(symbols: symbols)
    }

    public init(_ symbols: RomanNumeralSymbol...) throws {
        try self.init(symbols: symbols)
    }

    // MARK: Public Static Interface

    public static func string(fromSymbols symbols: [RomanNumeralSymbol]) -> String {
        return symbols.reduce("") { $0.appending(String($1.characterValue)) }
    }

    public static func symbols(fromString string: String) throws -> [RomanNumeralSymbol] {
        return try string.map { try RomanNumeralSymbol(from: $0) }
    }
}

// MARK: - Operators Extension

extension RomanNumeralProtocol {

    //TODO: fix the places where I poorly avoid the intValue error by using minimum

    // MARK: Public Static Interface

    //    public static func +(left: Self, right: Self) -> Self {
    //        let intResult = left.intValue + right.intValue
    //
    //        return (try? Self(intValue: intResult)) ?? .minimum
    //    }
    //
    //    public static func -(left: Self, right: Self) -> Self {
    //        let greaterSymbol = (left < right) ? right : left
    //        let lesserSymbol = (left < right) ? left : right
    //        let intResult = greaterSymbol.intValue - lesserSymbol.intValue
    //
    //        return (try? Self(intValue: intResult)) ?? .minimum
    //    }

}

// MARK: - Numeric Extension

extension RomanNumeralProtocol {

    // MARK: Public Computed Properties

    public var magnitude: Int {
        return intValue
    }

    // MARK: Public Intiatialization

    public init?<T>(exactly source: T) where T: BinaryInteger {
        guard let intValue = Int(exactly: source) else {
            return nil
        }

        try? self.init(intValue: intValue)
    }

}

// MARK: - Comparable Extension

extension RomanNumeralProtocol {

    // MARK: Public Static Interface

    public static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.intValue < rhs.intValue
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.intValue == rhs.intValue
    }

}

// MARK: - CustomDebugStringConvertible Extension

extension RomanNumeralProtocol {

    // MARK: Public Computed Properties

    public var debugDescription: String {
        return stringValue
    }

}

// MARK: - CustomStringConvertible Extension

extension RomanNumeralProtocol {

    // MARK: Public Computed Properties

    public var description: String {
        return stringValue
    }

}

// MARK: - ExpressibleByIntegerLiteral Extension

extension RomanNumeralProtocol {

    public init(integerLiteral: Int) {
        let safeIntValue: Int
        if integerLiteral < Self.minimumIntValue {
            safeIntValue = Self.minimumIntValue
        } else if Self.maximumIntValue < integerLiteral {
            safeIntValue = Self.maximumIntValue
        } else {
            safeIntValue = integerLiteral
        }

        try! self.init(intValue: safeIntValue)
    }

}

// MARK: - ExpressibleByStringLiteral Extension

extension RomanNumeralProtocol {

    // MARK: Public Initialization

    public init(stringLiteral value: String) {
        do {
            try self.init(from: value)
        } catch {
            os_log("Failed to decode Roman Numeral from String literal \"%s\" with error: %s",
                   log: .default,
                   type: .error,
                   [value, error.localizedDescription])

            self = .minimum
        }
    }

}
