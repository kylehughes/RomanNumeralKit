//
//  Int+SubtractiveNotationRomanNumeralConvertible.swift
//  RomanNumeralKit_iOS
//
//  Created by Kyle Hughes on 9/30/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation

//MARK: - SubtractiveNotationRomanNumeralConvertible Extension

extension Int: SubtractiveNotationRomanNumeralConvertible {
    
    //MARK: Public Properties
    
    public var subtractiveNotationRomanNumeral: SubtractiveNotationRomanNumeral? {
        return SubtractiveNotationRomanNumeral(intValue: self)
    }
    
}
