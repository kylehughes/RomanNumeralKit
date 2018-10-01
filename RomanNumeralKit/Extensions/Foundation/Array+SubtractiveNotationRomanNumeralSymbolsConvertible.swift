//
//  Array+SubtractiveNotationRomanNumeralSymbolsConvertible.swift
//  RomanNumeralKit_iOS
//
//  Created by Kyle Hughes on 9/30/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation

//MARK: -
//MARK: SubtractiveNotationRomanNumeralSymbolsConvertible Extension
//MARK: SubtractiveNotationRomanNumeralConvertible Extension

extension Array:
    SubtractiveNotationRomanNumeralSymbolsConvertible,
    SubtractiveNotationRomanNumeralConvertible
    where
    Element == RomanNumeralSymbol
{
    
    //MARK: Public Properties
    
    public var subtractiveNotationRomanNumeralSymbols: [RomanNumeralSymbol] {
        return self
    }
    
}
