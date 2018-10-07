//
//  RomanNumeral.swift
//  RomanNumeralKit
//
//  Created by Kyle Hughes on 9/30/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation

public struct RomanNumeral {
    
    //MARK: Public Static Properties
    
    public static let maximumIntValue = 3999
    public static let minimumIntValue = 1
    
    //MARK: Public Properties
    
    public private(set) var stringValue: String
    public private(set) var symbols: [RomanNumeralSymbol]
    
    public var intValue: Int {
        didSet {
            symbols = (try? RomanNumeral.symbols(fromIntValue: intValue)) ?? RomanNumeral.minimum.symbols
            stringValue = RomanNumeral.string(fromSymbols: symbols)
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
        guard RomanNumeral.minimumIntValue <= intValue else {
            throw RomanNumeralError.valueLessThanMinimum
        }
        
        guard intValue <= RomanNumeral.maximumIntValue else {
            throw RomanNumeralError.valueGreaterThanMaximum
        }
        
        var remainingIntValue = intValue
        var symbols: [SubtractiveRomanNumeralSymbol] = []
        
        SubtractiveRomanNumeralSymbol.allSymbolsDescending.forEach { symbol in
            let symbolValue = symbol.rawValue
            
            if symbolValue <= remainingIntValue {
                let symbolQuantity: Int = remainingIntValue / symbolValue
                let symbolBundle = Array(repeating: symbol, count: symbolQuantity)
                let totalSymbolValue = symbolQuantity * symbolValue
                remainingIntValue -= totalSymbolValue
                symbols.append(contentsOf: symbolBundle)
            }
        }
        
        let normalizedSymbols = symbols.map { $0.romanNumeralSymbols }.flatMap { $0 }
        
        return normalizedSymbols
    }
    
}

//MARK: - RomanNumeralProtocol Extension

extension RomanNumeral: RomanNumeralProtocol {


    //MARK: Public Initialization
    
    public init(intValue: Int) throws {
        guard RomanNumeral.minimumIntValue <= intValue else {
            throw RomanNumeralError.valueLessThanMinimum
        }
        
        guard intValue <= RomanNumeral.maximumIntValue else {
            throw RomanNumeralError.valueGreaterThanMaximum
        }
        
        self.intValue = intValue
        
        symbols = try RomanNumeral.symbols(fromIntValue: intValue)
        stringValue = RomanNumeral.string(fromSymbols: symbols)
    }
    
    public init(symbols: [RomanNumeralSymbol]) throws {
        self.symbols = symbols
        
        intValue = RomanNumeral.intValue(fromSymbols: symbols)
        stringValue = RomanNumeral.string(fromSymbols: symbols)
    }
    
    //MARK: Public Static Interface
    
    public static func condense(symbol: RomanNumeralSymbol, ofCount count: Int) -> [RomanNumeralSymbol] {
        //TODO: Implement
        // Use SubtractiveRomanNumeralSymbol, same algo as Basic I guess after that
        return []
    }
    
    public static func condense(symbols: [RomanNumeralSymbol]) -> [RomanNumeralSymbol] {
        //TODO: Implement
        return []
    }
    
}

//MARK: - RomanNumeralConvertible Extension

extension RomanNumeral: RomanNumeralConvertible {
    
    public var romanNumeral: RomanNumeral? {
        return self
    }
    
}


//MARK: - RomanNumeralSymbolsConvertible Extension

extension RomanNumeral: RomanNumeralSymbolsConvertible {
    
    public var romanNumeralSymbols: [RomanNumeralSymbol] {
        return symbols
    }
    
}

//MARK: - BasicNotationRomanNumeralConvertible Extension

extension RomanNumeral: BasicNotationRomanNumeralConvertible {
    
    public var basicNotationRomanNumeral: BasicNotationRomanNumeral? {
        return try? BasicNotationRomanNumeral(intValue: intValue)
    }

}

//MARK: - Operators Extension

extension RomanNumeral {
    
    //TODO: fix the places where I poorly avoid the intValue error by using minimum
    
    //MARK: Public Static Interface
    
    public static func +(left: RomanNumeral, right: RomanNumeral) -> RomanNumeral {
        //NOTE: Math is a super set of the algorithm for Basic, should find a way to reuse that. Just have to
        // do subtractive substitutions before and after
        let intResult = left.intValue + right.intValue

        return (try? RomanNumeral(intValue: intResult)) ?? .minimum
    }

    public static func -(left: RomanNumeral, right: RomanNumeral) -> RomanNumeral {
        let greaterSymbol = (left < right) ? right : left
        let lesserSymbol = (left < right) ? left : right
        let intResult = greaterSymbol.intValue - lesserSymbol.intValue

        return (try? RomanNumeral(intValue: intResult)) ?? .minimum
    }
    
}
