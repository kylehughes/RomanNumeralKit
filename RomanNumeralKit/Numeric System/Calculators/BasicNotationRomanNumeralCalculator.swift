//
//  BasicNotationRomanNumeralCalculator.swift
//  RomanNumeralKit
//
//  Created by Kyle Hughes on 4/19/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation

//MARK: - Implementation

class BasicNotationRomanNumeralCalculator {
}

//MARK: - RomanNumeralCalculator Extension

extension BasicNotationRomanNumeralCalculator: RomanNumeralCalculator {
    
    func calculcate(_ romanNumeralSymbols: [RomanNumeralSymbol]) -> Int {
        return romanNumeralSymbols.reduce(0) { $0 + $1.rawValue }
    }
    
}
