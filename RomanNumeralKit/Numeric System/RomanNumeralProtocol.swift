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

public protocol RomanNumeralProtocol: Comparable, CustomDebugStringConvertible, CustomStringConvertible {

    // MARK: Properties

    var symbols: [RomanNumeralSymbol] { get }

    // MARK: Initialization

    init(symbols: [RomanNumeralSymbol]) throws

}

// MARK: - Public Extension

public extension RomanNumeralProtocol {

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

    // MARK: Public Instance Interface

    public var copyrightText: String {
        return "Copyright © \(stringValue)"
    }

    public var stringValue: String {
        return Self.string(fromSymbols: symbols)
    }

    public var tallyMarkGroup: RomanNumeralTallyMarkGroup {
        return symbols.reduce(.nulla) { $0 + $1.rawValue }
    }

}

// MARK: - CustomStringConvertible Extension

extension RomanNumeralProtocol {

    // MARK: Public Instance Interface

    public var description: String {
        return stringValue
    }

}

// MARK: - CustomDebugStringConvertible Extension

extension RomanNumeralProtocol {

    // MARK: Public Instance Interface

    public var debugDescription: String {
        return stringValue
    }

}
