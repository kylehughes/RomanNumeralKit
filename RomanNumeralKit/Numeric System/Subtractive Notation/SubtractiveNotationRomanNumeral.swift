//
//  SubtractiveNotationRomanNumeral.swift
//  RomanNumeralKit
//
//  Created by Kyle Hughes on 9/30/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation

public struct SubtractiveNotationRomanNumeral {
    
    //MARK: Public Static Properties
    
    public static let maximumIntValue = 3999
    public static let minimumIntValue = 0
    
    //MARK: Public Properties
    
    public private(set) var stringValue: String
    public private(set) var symbols: [RomanNumeralSymbol]
    
    public var intValue: Int {
        didSet {
            symbols = (try? SubtractiveNotationRomanNumeral.symbols(fromIntValue: intValue)) ?? SubtractiveNotationRomanNumeral.minimum.symbols
            stringValue = SubtractiveNotationRomanNumeral.string(fromSymbols: symbols)
        }
    }
    
    //MARK: Private Static Interface
    
    private static func intValue(fromSymbols symbols: [RomanNumeralSymbol]) -> Int {
        var runningResult = 0
        var lastProcessedIndex = -1
        
        for (index, symbol) in symbols.enumerated() {
            guard lastProcessedIndex < index else {
                continue
            }
            
            if index + 1 < symbols.count {
                let nextSymbol = symbols[index + 1]
                
                if symbol < nextSymbol {
                    runningResult += (nextSymbol.rawValue - symbol.rawValue)
                } else {
                    runningResult += symbol.rawValue + nextSymbol.rawValue
                }
                
                lastProcessedIndex = index + 1
            } else {
                runningResult += symbol.rawValue
                lastProcessedIndex = index
            }
        }
        
        return runningResult
    }
    
    private static func symbols(fromIntValue intValue: Int) throws -> [RomanNumeralSymbol] {
        guard BasicNotationRomanNumeral.minimumIntValue <= intValue else {
            throw RomanNumeralError.valueLessThanMinimum
        }
        
        guard intValue <= BasicNotationRomanNumeral.maximumIntValue else {
            throw RomanNumeralError.valueGreaterThanMaximum
        }
        
        var remainingIntValue = intValue
        var symbols: [SubtractiveNotationRomanNumeralSymbol] = []
        
        SubtractiveNotationRomanNumeralSymbol.allSymbolsDescending.forEach { symbol in
            let symbolValue = symbol.rawValue
            
            if symbolValue <= remainingIntValue {
                let symbolQuantity: Int = remainingIntValue / symbolValue
                let symbolBundle = Array(repeating: symbol, count: symbolQuantity)
                let totalSymbolValue = symbolQuantity * symbolValue
                remainingIntValue -= totalSymbolValue
                symbols.append(contentsOf: symbolBundle)
            }
        }
        
        let normalizedSymbols = symbols.map { $0.subtractiveNotationRomanNumeralSymbols }.flatMap { $0 }
        
        return normalizedSymbols
    }
    
}

//MARK: - RomanNumeral Extension

extension SubtractiveNotationRomanNumeral: RomanNumeral {

    //MARK: Public Initialization
    
    public init(intValue: Int) throws {
        guard BasicNotationRomanNumeral.minimumIntValue <= intValue else {
            throw RomanNumeralError.valueLessThanMinimum
        }
        
        guard intValue <= BasicNotationRomanNumeral.maximumIntValue else {
            throw RomanNumeralError.valueGreaterThanMaximum
        }
        
        self.intValue = intValue
        
        symbols = try SubtractiveNotationRomanNumeral.symbols(fromIntValue: intValue)
        stringValue = SubtractiveNotationRomanNumeral.string(fromSymbols: symbols)
    }
    
    public init(symbols: [RomanNumeralSymbol]) throws {
        self.symbols = symbols
        
        intValue = SubtractiveNotationRomanNumeral.intValue(fromSymbols: symbols)
        stringValue = SubtractiveNotationRomanNumeral.string(fromSymbols: symbols)
    }
    
}

//MARK: - SubtractiveNotationRomanNumeralConvertible Extension

extension SubtractiveNotationRomanNumeral: SubtractiveNotationRomanNumeralConvertible {
    
    public var subtractiveNotationRomanNumeral: SubtractiveNotationRomanNumeral? {
        return self
    }
    
}


//MARK: - SubtractiveNotationRomanNumeralSymbolsConvertible Extension

extension SubtractiveNotationRomanNumeral: SubtractiveNotationRomanNumeralSymbolsConvertible {
    
    public var subtractiveNotationRomanNumeralSymbols: [RomanNumeralSymbol] {
        return symbols
    }
    
}

//MARK: - BasicNotationRomanNumeralConvertible Extension

extension SubtractiveNotationRomanNumeral: BasicNotationRomanNumeralConvertible {
    
    public var basicNotationRomanNumeral: BasicNotationRomanNumeral? {
        return try? BasicNotationRomanNumeral(intValue: intValue)
    }

}
