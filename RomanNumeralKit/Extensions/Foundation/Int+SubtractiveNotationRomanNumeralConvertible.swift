//
//  Int+SubtractiveNotationRomanNumeralConvertible.swift
//  RomanNumeralKit
//
//  Created by Kyle Hughes on 9/30/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation

// MARK: - RomanNumeralConvertible Extension

extension Int: RomanNumeralConvertible {

    // MARK: Public Properties

    public var romanNumeral: RomanNumeral? {
        return try? RomanNumeral(intValue: self)
    }

}
