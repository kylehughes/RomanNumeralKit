//
//  SubtractiveNotationRomanNumeral.swift
//  RomanNumeralKit_iOS
//
//  Created by Kyle Hughes on 9/30/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation

public struct SubtractiveNotationRomanNumeral {
    
    //MARK: Public Static Properties
    
    public static let maximumIntValue = 3999
    public static let minimumIntValue = 0
    
    public static let maximum = SubtractiveNotationRomanNumeral(intValue: maximumIntValue)
    public static let minimum = SubtractiveNotationRomanNumeral(intValue: minimumIntValue)
    
    //MARK: Public Properties
    
    public private(set) var stringValue: String
    public private(set) var symbols: [RomanNumeralSymbol]
    
    public var intValue: Int {
        didSet {
            symbols = SubtractiveNotationRomanNumeral.symbols(fromIntValue: intValue)
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
    
    private static func symbols(fromIntValue intValue: Int) -> [RomanNumeralSymbol] {
        return []
    }
    
}

//MARK: - RomanNumeral Extension

extension SubtractiveNotationRomanNumeral: RomanNumeral {
    
    //MARK: Public Initialization
    
    public init(intValue: Int) {
        self.intValue = intValue
        
        symbols = SubtractiveNotationRomanNumeral.symbols(fromIntValue: intValue)
        stringValue = SubtractiveNotationRomanNumeral.string(fromSymbols: symbols)
    }
    
    public init(symbols: [RomanNumeralSymbol]) throws {
        self.symbols = symbols
        
        intValue = SubtractiveNotationRomanNumeral.intValue(fromSymbols: symbols)
        stringValue = SubtractiveNotationRomanNumeral.string(fromSymbols: symbols)
    }
    
}

//MARK: - SubtractiveNotationRomanNumeralSymbolsConvertible Extension

extension SubtractiveNotationRomanNumeral: SubtractiveNotationRomanNumeralSymbolsConvertible {
    
    public var subtractiveNotationRomanNumeralSymbols: [RomanNumeralSymbol] {
        return symbols
    }
    
}
