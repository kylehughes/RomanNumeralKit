//
//  IntRomanNumeralSymbolConverter.swift
//  RomanNumeralKit
//
//  Created by Kyle Hughes on 4/19/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation

//MARK: - Implementation

protocol IntRomanNumeralSymbolConverter {
    
    func romanNumeralSymbols(fromInt intValue: Int) -> [RomanNumeralSymbol]
    
}
