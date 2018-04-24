//
//  IntBasicNotationRomanNumeralSymbolConverter.swift
//  RomanNumeralKit
//
//  Created by Kyle Hughes on 4/19/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation

struct BasicNotationIntRomanNumeralSymbolConverter {
    
}

//MARK: - IntRomanNumeralSymbolConverter Extension

extension BasicNotationIntRomanNumeralSymbolConverter: IntRomanNumeralSymbolConverter {
    
    func romanNumeralSymbols(fromInt intValue: Int) -> [RomanNumeralSymbol] {
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
