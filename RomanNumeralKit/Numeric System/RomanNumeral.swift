//
//  RomanNumeral.swift
//  RomanNumeralKit
//
//  Created by Kyle Hughes on 4/16/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation

enum RomanNumeralError: Error {
    
    case incompatibleNotationOperation
    
}

//MARK: - Implementation

public struct RomanNumeral {
    
    //MARK: Public Static Properties
    
    public static let zero = RomanNumeral(intValue: 0, notation: .basic)
    
    public static let defaultNotation = RomanNumeralNotation.subtractive
    
    //MARK: Public Properties
    
    public var intValue: Int {
        didSet {
            symbols = symbolConverter.romanNumeralSymbols(fromInt: intValue)
        }
    }
    
    public let notation: RomanNumeralNotation
    
    public private(set) var symbols: [RomanNumeralSymbol]
    
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
        
        self.calculator = RomanNumeral.newCalculator(forNotation: self.notation)
        self.symbolConverter = RomanNumeral.newSymbolConverter(forNotation: self.notation)
        self.intValue = calculator.calculcate(self.symbols)
    }
    
    public init(intValue: Int, notation: RomanNumeralNotation = RomanNumeral.defaultNotation) {
        self.intValue = intValue
        self.notation = notation
        
        self.calculator = RomanNumeral.newCalculator(forNotation: self.notation)
        self.symbolConverter = RomanNumeral.newSymbolConverter(forNotation: self.notation)
        
        var symbols: [RomanNumeralSymbol] = []
        var remainingIntValue = self.intValue
        RomanNumeralSymbol.allSymbolsDescending.forEach { symbol in
            let symbolCount = remainingIntValue / symbol.rawValue
            
            guard symbolCount > 0 else {
                return
            }
            
            if symbolCount == 4 {
                //TODO
            }
            
            symbols.append(contentsOf: Array(repeating: symbol, count: symbolCount))
            remainingIntValue = remainingIntValue - (symbol.rawValue * symbolCount)
        }
        self.symbols = symbols
    }
    
    //MARK: Private Interface
    
    private static func newCalculator(forNotation notation: RomanNumeralNotation) -> RomanNumeralCalculator {
        switch notation {
        case .basic:
            return BasicNotationRomanNumeralCalculator()
        case .subtractive:
            return SubtractiveNotationRomanNumeralCalculator()
        }
    }
    
    private static func newSymbolConverter(forNotation notation: RomanNumeralNotation) -> IntRomanNumeralSymbolConverter {
        switch notation {
        case .basic:
            return BasicNotationIntRomanNumeralSymbolConverter()
        case .subtractive:
            return SubtractiveNotationIntRomanNumeralSymbolConverter()
        }
    }
    
}

//MARK: - Operators

extension RomanNumeral {
    
    static public func +(left: RomanNumeral, right: RomanNumeral) -> RomanNumeral {
        guard left.notation == right.notation else {
//            throw RomanNumeralError.incompatibleNotationOperation
            return .zero
        }
        
        let intResult = left.intValue + right.intValue
        let notation = left.notation
        
        return RomanNumeral(intValue: intResult, notation: notation)
    }
    
    static public func -(left: RomanNumeral, right: RomanNumeral) -> RomanNumeral {
        guard left.notation == right.notation else {
//            throw RomanNumeralError.incompatibleNotationOperation
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
        return lhs.intValue < rhs.intValue
    }
    
    static public func ==(lhs: RomanNumeral, rhs: RomanNumeral) -> Bool {
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
        lhs.intValue -= rhs.intValue
    }
    
    public static func +=(lhs: inout RomanNumeral, rhs: RomanNumeral) {
        lhs.intValue += rhs.intValue
    }
    
    public static func *(lhs: RomanNumeral, rhs: RomanNumeral) -> RomanNumeral {
        guard lhs.notation == rhs.notation else {
//            throw RomanNumeralError.incompatibleNotationOperation
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
