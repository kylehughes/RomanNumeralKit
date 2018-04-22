//
//  SubtractiveNotationRomanNumeralCalculator.swift
//  RomanNumeralKit
//
//  Created by Kyle Hughes on 4/19/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation

//MARK: - Implementation

class SubtractiveNotationRomanNumeralCalculator {
}

//MARK: - RomanNumeralCalculator Extension

extension SubtractiveNotationRomanNumeralCalculator: RomanNumeralCalculator {
    
    func calculcate(_ romanNumeralSymbols: [RomanNumeralSymbol]) -> Int {
        var runningResult = 0
        var lastProcessedIndex = -1
        for (index, symbol) in romanNumeralSymbols.enumerated() {
            guard lastProcessedIndex < index else {
                continue
            }
            
            if index + 1 < romanNumeralSymbols.count {
                let nextSymbol = romanNumeralSymbols[index + 1]
                if symbol < nextSymbol {
                    runningResult += (nextSymbol.rawValue - symbol.rawValue)
                } else {
                    runningResult += symbol.rawValue + nextSymbol.rawValue
                }
                
                lastProcessedIndex = index + 1
            } else {
                runningResult += symbol.rawValue
                lastProcessedIndex = index
            }
        }
        
        return runningResult
    }
    
}
