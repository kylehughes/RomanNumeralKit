//
//  SubtractiveNotationRomanNumeralSymbolsConvertible.swift
//  RomanNumeralKit
//
//  Created by Kyle Hughes on 9/30/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation

protocol SubtractiveNotationRomanNumeralSymbolsConvertible: SubtractiveNotationRomanNumeralConvertible {
    
    //MARK: Properties
    
    var subtractiveNotationRomanNumeralSymbols: [RomanNumeralSymbol] { get }
    
}

//MARK: - SubtractiveNotationRomanNumeralConvertible Extension

extension SubtractiveNotationRomanNumeralSymbolsConvertible {
    
    var subtractiveNotationRomanNumeral: SubtractiveNotationRomanNumeral? {
        return try? SubtractiveNotationRomanNumeral(symbols: subtractiveNotationRomanNumeralSymbols)
    }
    
}
