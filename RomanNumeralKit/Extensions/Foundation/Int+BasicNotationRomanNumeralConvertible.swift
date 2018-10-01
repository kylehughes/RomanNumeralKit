//
//  Int+BasicNotationRomanNumeralConvertible.swift
//  RomanNumeralKit_iOS
//
//  Created by Kyle Hughes on 9/30/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation

//MARK: - BasicNotationRomanNumeralConvertible Extension

extension Int: BasicNotationRomanNumeralConvertible {
    
    //MARK: Public Properties

    public var basicNotationRomanNumeral: BasicNotationRomanNumeral? {
        return BasicNotationRomanNumeral(intValue: self)
    }
    
}