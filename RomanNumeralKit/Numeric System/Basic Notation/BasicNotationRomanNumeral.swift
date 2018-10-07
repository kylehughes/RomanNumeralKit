//
//  BasicNotationRomanNumeral.swift
//  RomanNumeralKit
//
//  Created by Kyle Hughes on 9/30/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation

public struct BasicNotationRomanNumeral {
    
    //MARK: Public Static Properties
    
    public static let maximumIntValue = 3999
    public static let minimumIntValue = 1
    
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

//MARK: - RomanNumeralProtocol Extension

extension BasicNotationRomanNumeral: RomanNumeralProtocol {
    
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
    
    //MARK: Public Static Interface
    
    public static func reduce(symbol: RomanNumeralSymbol, ofCount count: Int) -> [RomanNumeralSymbol] {
        let allSymbols = RomanNumeralSymbol.allSymbols
        
        guard let symbolIndex = allSymbols.firstIndex(of: symbol) else {
            // The collection must be misconfigured for there to be a symbol miss
            return []
        }
        
        let nextHighestSymbolIndex = symbolIndex + 1
        
        guard nextHighestSymbolIndex < allSymbols.count else {
            return Array(repeating: symbol, count: count)
        }
        
        //TODO: Somehow avoid referencing intValue?
        let nextHighestSymbol = allSymbols[nextHighestSymbolIndex]
        let totalSymbolValue = symbol.rawValue * count
        let nextHighestSymbolQuantity = totalSymbolValue / nextHighestSymbol.rawValue
        let totalNextHighestSymbolValue = nextHighestSymbol.rawValue * nextHighestSymbolQuantity
        let remainingSymbolValue = totalSymbolValue - totalNextHighestSymbolValue
        let remainingSymbolQuanity = remainingSymbolValue / symbol.rawValue
        let nextHighestSymbols = Array(repeating: nextHighestSymbol, count: nextHighestSymbolQuantity)
        let remainingSymbols = Array(repeating: symbol, count: remainingSymbolQuanity)
        
        return nextHighestSymbols + remainingSymbols
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

//MARK: - RomanNumeralConvertible Extension

extension BasicNotationRomanNumeral: RomanNumeralConvertible {
    
    public var romanNumeral: RomanNumeral? {
        return try? RomanNumeral(intValue: intValue)
    }
    
}

//MARK: - Operators Extension

extension BasicNotationRomanNumeral {
    
    //TODO: fix the places where I poorly avoid the intValue error by using minimum
    
    //MARK: Public Static Interface
    
    public static func +(left: BasicNotationRomanNumeral, right: BasicNotationRomanNumeral) -> BasicNotationRomanNumeral {
        // Algorithm: http://turner.faculty.swau.edu/mathematics/materialslibrary/roman/
        
        let allSymbols = left.symbols + right.symbols
        let allSymbolsDescending = allSymbols.sorted(by: >)
        
        // TODO: Fix this deviation on the algo, should go RTL, no filtering just track range
        var allReducedSymbols = allSymbolsDescending
        for symbol in RomanNumeralSymbol.allSymbols {
            let allOfSymbol = allReducedSymbols.filter { $0 == symbol }
            let reducedSymbols = BasicNotationRomanNumeral.reduce(symbol: symbol, ofCount: allOfSymbol.count)
            
            guard
                let startIndexOfSymbol = allReducedSymbols.firstIndex(of: symbol),
                let endIndexOfSymbol = allReducedSymbols.lastIndex(of: symbol) else
            {
                continue
            }
            
            allReducedSymbols.replaceSubrange(startIndexOfSymbol...endIndexOfSymbol, with: reducedSymbols)
        }
        
        return (try? BasicNotationRomanNumeral(symbols: allReducedSymbols)) ?? .minimum
    }

    public static func -(left: BasicNotationRomanNumeral, right: BasicNotationRomanNumeral) -> BasicNotationRomanNumeral {
        // Algorithm: http://turner.faculty.swau.edu/mathematics/materialslibrary/roman/
        
        let greaterSymbol = (left < right) ? right : left
        let lesserSymbol = (left < right) ? left : right
        let intResult = greaterSymbol.intValue - lesserSymbol.intValue

        return (try? BasicNotationRomanNumeral(intValue: intResult)) ?? .minimum
    }
    
}
