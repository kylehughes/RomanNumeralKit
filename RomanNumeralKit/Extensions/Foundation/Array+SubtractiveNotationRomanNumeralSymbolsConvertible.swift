//
//  Array+SubtractiveNotationRomanNumeralSymbolsConvertible.swift
//  RomanNumeralKit
//
//  Created by Kyle Hughes on 9/30/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation

//MARK: -
//MARK: SubtractiveNotationRomanNumeralSymbolsConvertible Extension
//MARK: SubtractiveNotationRomanNumeralConvertible Extension
//MARK: where Element == RomanNumeralSymbol

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
