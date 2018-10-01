//
//  RomanNumeral.swift
//  RomanNumeralKit_iOS
//
//  Created by Kyle Hughes on 9/30/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation
import os

public protocol RomanNumeral:
    Comparable,
    CustomStringConvertible,
    ExpressibleByStringLiteral,
    Numeric
    where
    Self.IntegerLiteralType == Int,
    Self.Magnitude == Int
{
    
    //MARK: Static Properties
    
    static var maximum: Self { get }
    static var minimum: Self { get }
    
    //MARK: Properties
    
    var intValue: Int { get set }
    var stringValue: String { get }
    var symbols: [RomanNumeralSymbol] { get }
    
    //MARK: Initialization
    
    init(intValue: Int)
    init(symbols: [RomanNumeralSymbol]) throws
    
}

//MARK: Public Extension

public extension RomanNumeral {
    
    //MARK: Public Static Properties
    
    public static var zero: Self {
        return Self(intValue: 0)
    }
    
    //MARK: Public Initialization
    
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
    
    //MARK: Public Static Interface
    
    public static func string(fromSymbols symbols: [RomanNumeralSymbol]) -> String {
        return symbols.reduce("") { $0.appending(String($1.characterValue)) }
    }
    
    public static func symbols(fromString string: String) throws -> [RomanNumeralSymbol] {
        return try string.map { try RomanNumeralSymbol(from: $0) }
    }
    
}

//MARK: - Operators Extension

extension RomanNumeral {
    
    static public func +(left: Self, right: Self) -> Self {
        let intResult = left.intValue + right.intValue
        
        return Self(intValue: intResult)
    }
    
    static public func -(left: Self, right: Self) -> Self {
        let greaterSymbol = (left < right) ? right : left
        let lesserSymbol = (left < right) ? left : right
        let intResult = greaterSymbol.intValue - lesserSymbol.intValue
        
        return Self(intValue: intResult)
    }
    
}

//MARK: - Numeric Extension

extension RomanNumeral {
    
    //MARK: Public Properties
    
    public var magnitude: Int {
        return intValue
    }
    
    //MARK: Public Intiatialization
    
    public init?<T>(exactly source: T) where T : BinaryInteger {
        guard let intValue = Int(exactly: source) else {
            return nil
        }
        
        self.init(intValue: intValue)
    }
    
    public init(integerLiteral value: Int) {
        self.init(intValue: value)
    }
    
    //MARK: Public Static Interface
    
    public static func -=(lhs: inout Self, rhs: Self) {
        lhs.intValue -= rhs.intValue
    }
    
    public static func +=(lhs: inout Self, rhs: Self) {
        lhs.intValue += rhs.intValue
    }
    
    public static func *(lhs: Self, rhs: Self) -> Self {
        let resultIntValue = lhs.intValue * rhs.intValue
        let resultRomanNumeral = Self(intValue: resultIntValue)
        
        return resultRomanNumeral
    }
    
    public static func *=(lhs: inout Self, rhs: Self) {
        lhs.intValue *= rhs.intValue
    }
    
}

//MARK: - Comparable Extension

extension RomanNumeral {
    
    //MARK: Public Static Interface
    
    public static func <(lhs: Self, rhs: Self) -> Bool {
        return lhs.intValue < rhs.intValue
    }
    
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.intValue == rhs.intValue
    }
    
}

//MARK: - CustomStringConvertible Extension

extension RomanNumeral {
    
    //MARK: Public Properties
    
    public var description: String {
        return stringValue
    }
    
}

//MARK: - ExpressibleByStringLiteral Extension

extension RomanNumeral {
    
    //MARK: Public Initialization
    
    public init(stringLiteral value: String) {
        do {
            try self.init(from: value)
        } catch {
            os_log("Failed to decode Roman Numeral from String literal \"%s\" with error: %s",
                   log: .default,
                   type: .error,
                   [value, error.localizedDescription])
            
            self.init(intValue: 0)
        }
    }
    
}
