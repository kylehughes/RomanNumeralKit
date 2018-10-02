//
//  RomanNumeralSymbolsConvertible.swift
//  RomanNumeralKit
//
//  Created by Kyle Hughes on 9/30/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation

protocol RomanNumeralSymbolsConvertible: RomanNumeralConvertible {
    
    //MARK: Properties
    
    var romanNumeralSymbols: [RomanNumeralSymbol] { get }
    
}

//MARK: - RomanNumeralConvertible Extension

extension RomanNumeralSymbolsConvertible {
    
    var romanNumeral: RomanNumeral? {
        return try? RomanNumeral(symbols: romanNumeralSymbols)
    }
    
}
