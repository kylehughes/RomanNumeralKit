//
//  BasicNotationRomanNumeral.swift
//  RomanNumeralKit_iOS
//
//  Created by Kyle Hughes on 9/30/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation

public struct BasicNotationRomanNumeral {
    
    //MARK: Public Static Properties
    
    public static let maximumIntValue = 3999
    public static let minimumIntValue = 0
    
    //MARK: Public Properties
    
    public private(set) var stringValue: String
    public private(set) var symbols: [RomanNumeralSymbol]
    
    public var intValue: Int {
        didSet {
            symbols = BasicNotationRomanNumeral.symbols(fromIntValue: intValue)
            stringValue = BasicNotationRomanNumeral.string(fromSymbols: symbols)
        }
    }
    
    //MARK: Private Static Interface
    
    private static func intValue(fromSymbols symbols: [RomanNumeralSymbol]) -> Int {
        return symbols.reduce(0) { $0 + $1.rawValue }
    }
    
    private static func symbols(fromIntValue intValue: Int) -> [RomanNumeralSymbol] {
        var remainingIntValue = intValue
        var convertedSymbols: [RomanNumeralSymbol] = []
        
        RomanNumeralSymbol.allSymbolsDescending.forEach { symbol in
            let symbolCount: Int = remainingIntValue / symbol.rawValue
            guard 0 < symbolCount else {
                return
            }
            
            let consecutiveSymbols = Array(repeating: symbol, count: symbolCount)
            convertedSymbols.append(contentsOf: consecutiveSymbols)
            remainingIntValue -= symbolCount * symbol.rawValue
        }
        
        return convertedSymbols
    }
    
}

//MARK: - RomanNumeral Extension

extension BasicNotationRomanNumeral: RomanNumeral {
    
    //MARK: Public Initialization

    public init(intValue: Int) throws {
        guard BasicNotationRomanNumeral.minimumIntValue <= intValue else {
            throw RomanNumeralError.valueLessThanMinimum
        }
        
        guard intValue <= BasicNotationRomanNumeral.maximumIntValue else {
            throw RomanNumeralError.valueGreaterThanMaximum
        }
        
        self.intValue = intValue

        symbols = BasicNotationRomanNumeral.symbols(fromIntValue: intValue)
        stringValue = BasicNotationRomanNumeral.string(fromSymbols: symbols)
    }
    
    public init(symbols: [RomanNumeralSymbol]) throws {
        self.symbols = symbols
        
        intValue = BasicNotationRomanNumeral.intValue(fromSymbols: symbols)
        stringValue = BasicNotationRomanNumeral.string(fromSymbols: symbols)
    }
    
}

//MARK: - BasicNotationRomanNumeralSymbolsConvertible Extension

extension BasicNotationRomanNumeral: BasicNotationRomanNumeralConvertible {
    
    public var basicNotationRomanNumeral: BasicNotationRomanNumeral? {
        return self
    }
    
}

//MARK: - BasicNotationRomanNumeralSymbolsConvertible Extension

extension BasicNotationRomanNumeral: BasicNotationRomanNumeralSymbolsConvertible {
    
    public var basicNotationRomanNumeralSymbols: [RomanNumeralSymbol] {
        return symbols
    }
    
}

//MARK: - SubtractiveNotationRomanNumeralConvertible Extension

extension BasicNotationRomanNumeral: SubtractiveNotationRomanNumeralConvertible {
    
    public var subtractiveNotationRomanNumeral: SubtractiveNotationRomanNumeral? {
        return try? SubtractiveNotationRomanNumeral(intValue: intValue)
    }
    
}
