//
//  BasicNotationRomanNumeralSymbolsConvertible.swift
//  RomanNumeralKit_iOS
//
//  Created by Kyle Hughes on 9/30/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation

public protocol BasicNotationRomanNumeralSymbolsConvertible: BasicNotationRomanNumeralConvertible {
    
    //MARK: Properties
    
    var basicNotationRomanNumeralSymbols: [RomanNumeralSymbol] { get }
    
}

//MARK: - BasicNotationConvertible Extension

extension BasicNotationRomanNumeralSymbolsConvertible {
    
    //MARK: Public Properties
    
    public var basicNotationRomanNumeral: BasicNotationRomanNumeral? {
        return try? BasicNotationRomanNumeral(symbols: basicNotationRomanNumeralSymbols)
    }
    
}
