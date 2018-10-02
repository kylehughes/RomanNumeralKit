//
//  Array+BasicNotationRomanNumeralSymbolsConvertible.swift
//  RomanNumeralKit
//
//  Created by Kyle Hughes on 9/30/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation

//MARK: -
//MARK: BasicNotationRomanNumeralSymbolsConvertible Extension
//MARK: BasicNotationRomanNumeralConvertible Extension

extension Array:
    BasicNotationRomanNumeralSymbolsConvertible,
    BasicNotationRomanNumeralConvertible
    where
    Element == RomanNumeralSymbol
{
    
    //MARK: Public Properties
    
    public var basicNotationRomanNumeralSymbols: [RomanNumeralSymbol] {
        return self
    }
    
}
