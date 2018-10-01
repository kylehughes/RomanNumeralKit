//
//  String+SubtractiveNotationRomanNumeralSymbolsConvertible.swift
//  RomanNumeralKit_iOS
//
//  Created by Kyle Hughes on 9/30/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation

//MARK: - SubtractiveNotationRomanNumeralSymbolsConvertible Extension

extension String: SubtractiveNotationRomanNumeralSymbolsConvertible {
    
    //MARK: Public Properties
    
    public var subtractiveNotationRomanNumeralSymbols: [RomanNumeralSymbol] {
        return compactMap { try? RomanNumeralSymbol(from: $0) }
    }
    
}
