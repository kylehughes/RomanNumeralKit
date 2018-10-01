//
//  RomanNumeral.swift
//  RomanNumeralKit
//
//  Created by Kyle Hughes on 4/16/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation
import os

//MARK: - Implementation

public struct RomanNumeral {
    
    //MARK: Public Static Properties
    
    public static let maximum = RomanNumeral(intValue: RomanNumeral.maximumIntValue)
    public static let minimum = RomanNumeral(intValue: RomanNumeral.minimumIntValue)
    public static let zero = RomanNumeral(intValue: 0)
    
    public static let defaultNotation = RomanNumeralNotation.subtractive
    
    public static let maximumIntValue = 3999
    public static let minimumIntValue = 0
    
    //MARK: Public Properties
    
    public var intValue: Int {
        didSet {
            symbols = symbolConverter.romanNumeralSymbols(fromInt: intValue)
            stringValue = RomanNumeral.stringRepresentation(fromSymbols: symbols)
        }
    }
    
    public let notation: RomanNumeralNotation
    
    public private(set) var symbols: [RomanNumeralSymbol]
    public private(set) var stringValue: String
    
    //MARK: Private Properties
    
    private let calculator: RomanNumeralCalculator
    private let symbolConverter: IntRomanNumeralSymbolConverter
    
    private var iteratorCounter = 0
    
    //MARK: Initialization
    
    public init(from stringValue: String, notation: RomanNumeralNotation = RomanNumeral.defaultNotation) throws {
        let symbols = try stringValue.map { try RomanNumeralSymbol(from: $0) }
        try self.init(symbols: symbols, notation: notation)
    }
    
    public init(symbols: [RomanNumeralSymbol], notation: RomanNumeralNotation = RomanNumeral.defaultNotation) throws {
        self.symbols = symbols
        self.notation = notation
        
        self.calculator = RomanNumeral.initCalculator(forNotation: self.notation)
        self.symbolConverter = RomanNumeral.initSymbolConverter(forNotation: self.notation)
        self.intValue = self.calculator.calculcate(self.symbols)
        self.stringValue = RomanNumeral.stringRepresentation(fromSymbols: self.symbols)
    }
    
    public init(intValue: Int, notation: RomanNumeralNotation = RomanNumeral.defaultNotation) {
        self.intValue = intValue
        self.notation = notation
        
        self.calculator = RomanNumeral.initCalculator(forNotation: self.notation)
        self.symbolConverter = RomanNumeral.initSymbolConverter(forNotation: self.notation)
        self.symbols = self.symbolConverter.romanNumeralSymbols(fromInt: self.intValue)
        self.stringValue = RomanNumeral.stringRepresentation(fromSymbols: self.symbols)
    }
    
    public init(_ otherRomanNumeral: RomanNumeral, notation: RomanNumeralNotation) {
        self.symbols = otherRomanNumeral.symbols
        self.notation = notation
        
        self.calculator = RomanNumeral.initCalculator(forNotation: self.notation)
        self.symbolConverter = RomanNumeral.initSymbolConverter(forNotation: self.notation)
        self.intValue = self.calculator.calculcate(self.symbols)
        self.stringValue = RomanNumeral.stringRepresentation(fromSymbols: self.symbols)
    }
    
    //MARK: Private Static Interface
    
    private static func initCalculator(forNotation notation: RomanNumeralNotation) -> RomanNumeralCalculator {
        let calculator: RomanNumeralCalculator
        switch notation {
        case .basic:
            calculator = BasicNotationRomanNumeralCalculator()
        case .subtractive:
            calculator = SubtractiveNotationRomanNumeralCalculator()
        }
        
        return calculator
    }
    
    private static func initSymbolConverter(forNotation notation: RomanNumeralNotation) -> IntRomanNumeralSymbolConverter {
        let symbolConverter: IntRomanNumeralSymbolConverter
        switch notation {
        case .basic:
            symbolConverter = BasicNotationIntRomanNumeralSymbolConverter()
        case .subtractive:
            symbolConverter = SubtractiveNotationIntRomanNumeralSymbolConverter()
        }
        
        return symbolConverter
    }
    
    private static func stringRepresentation(fromSymbols symbols: [RomanNumeralSymbol]) -> String {
        return symbols.reduce("") { partialResult, symbol in
            return partialResult.appending(String(symbol.characterValue))
        }
    }
    
}

//MARK: - Operators

extension RomanNumeral {
    
    static public func +(left: RomanNumeral, right: RomanNumeral) -> RomanNumeral {
        guard left.notation == right.notation else {
            os_log("Invalid `+` operation between %s ($s) and %s (%s)",
                   log: .default,
                   type: .error,
                   [left, left.notation, right, right.notation])
            
            return .zero
        }
        
        let intResult = left.intValue + right.intValue
        let notation = left.notation
        
        return RomanNumeral(intValue: intResult, notation: notation)
    }
    
    static public func -(left: RomanNumeral, right: RomanNumeral) -> RomanNumeral {
        guard left.notation == right.notation else {
            os_log("Invalid `-` operation between %s ($s) and %s (%s)",
                   log: .default,
                   type: .error,
                   [left, left.notation, right, right.notation])
            
            return .zero
        }
        
        let greaterSymbol = (left < right) ? right : left
        let lesserSymbol = (left < right) ? left : right
        let intResult = greaterSymbol.intValue - lesserSymbol.intValue
        let notation = left.notation
        
        return RomanNumeral(intValue: intResult, notation: notation)
    }
    
}

//MARK: - Comparable Extension

extension RomanNumeral: Comparable {
    
    static public func <(lhs: RomanNumeral, rhs: RomanNumeral) -> Bool {
        guard lhs.notation == rhs.notation else {
            os_log("Invalid `==` operation between %s ($s) and %s (%s)",
                   log: .default,
                   type: .error,
                   [lhs, lhs.notation, rhs, rhs.notation])
            
            return false
        }
        
        return lhs.intValue < rhs.intValue
    }
    
    static public func ==(lhs: RomanNumeral, rhs: RomanNumeral) -> Bool {
        guard lhs.notation == rhs.notation else {
            os_log("Invalid `==` operation between %s ($s) and %s (%s)",
                   log: .default,
                   type: .error,
                   [lhs, lhs.notation, rhs, rhs.notation])
            
            return false
        }
        
        return lhs.intValue == rhs.intValue
    }
 
}

//MARK: - Sequence Extension

extension RomanNumeral: Sequence, IteratorProtocol {

    public typealias Element = RomanNumeralSymbol

    public mutating func next() -> Element? {
        guard iteratorCounter < symbols.count else {
            return nil
        }
        
        let symbol = symbols[iteratorCounter]
        iteratorCounter += 1
        
        return symbol
    }
    
}

//MARK: - Numeric Extension

extension RomanNumeral: Numeric {

    public typealias Magnitude = Int
    
    public typealias IntegerLiteralType = Int
    
    //MARK: Public Computed Properties
    
    public var magnitude: Int {
        return intValue
    }
    
    //MARK: Public Intiatialization
    
    public init?<T>(exactly source: T) where T : BinaryInteger {
        guard let intValue = Int(exactly: source) else {
            return nil
        }
        
        self.init(intValue: intValue, notation: RomanNumeral.defaultNotation)
    }
    
    public init(integerLiteral value: Int) {
        self.init(intValue: value, notation: RomanNumeral.defaultNotation)
    }
    
    //MARK: Public Static Interface
    
    public static func -=(lhs: inout RomanNumeral, rhs: RomanNumeral) {
        guard lhs.notation == rhs.notation else {
            os_log("Invalid -= operation between %s ($s) and %s (%s)",
                   log: .default,
                   type: .error,
                   [lhs, lhs.notation, rhs, rhs.notation])
            
            return
        }
        
        lhs.intValue -= rhs.intValue
    }
    
    public static func +=(lhs: inout RomanNumeral, rhs: RomanNumeral) {
        guard lhs.notation == rhs.notation else {
            os_log("Invalid += operation between %s ($s) and %s (%s)",
                   log: .default,
                   type: .error,
                   [lhs, lhs.notation, rhs, rhs.notation])
            
            return
        }
        
        lhs.intValue += rhs.intValue
    }
    
    public static func *(lhs: RomanNumeral, rhs: RomanNumeral) -> RomanNumeral {
        guard lhs.notation == rhs.notation else {
            os_log("Invalid * operation between %s ($s) and %s (%s)",
                   log: .default,
                   type: .error,
                   [lhs, lhs.notation, rhs, rhs.notation])
            
            return .zero
        }
        
        let resultIntValue = lhs.intValue * rhs.intValue
        let notation = lhs.notation
        let resultRomanNumeral = RomanNumeral(intValue: resultIntValue, notation: notation)
        
        return resultRomanNumeral
    }
    
    public static func *=(lhs: inout RomanNumeral, rhs: RomanNumeral) {
        lhs.intValue *= rhs.intValue
    }
    
}

//MARK: - CustomStringConvertible Extension

extension RomanNumeral: CustomStringConvertible {
    
    public var description: String {
        return stringValue
    }
    
}

//MARK: - ExpressibleByStringLiteral Extension

extension RomanNumeral: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: String) {
        do {
            try self.init(from: value)
        } catch {
            os_log("Failed to decode Roman Numeral from String \"%s\" with error: %s",
                   log: .default,
                   type: .error,
                   [value, error.localizedDescription])
            
            self.init(intValue: 0)
        }
    }
    
}
