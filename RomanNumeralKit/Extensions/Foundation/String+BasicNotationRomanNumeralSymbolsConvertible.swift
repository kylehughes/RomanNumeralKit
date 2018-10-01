//
//  String+BasicNotationRomanNumeralSymbolsConvertible.swift
//  RomanNumeralKit_iOS
//
//  Created by Kyle Hughes on 9/30/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation

//MARK: - BasicNotationRomanNumeralSymbolsConvertible Extension

extension String: BasicNotationRomanNumeralSymbolsConvertible {
    
    //MARK: Public Properties
    
    public var basicNotationRomanNumeralSymbols: [RomanNumeralSymbol] {
        return (try? BasicNotationRomanNumeral.symbols(fromString: self)) ?? []
    }
    
}
