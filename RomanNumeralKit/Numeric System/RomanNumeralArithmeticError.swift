//
//  RomanNumeralArithmeticError.swift
//  RomanNumeralKit
//
//  Created by Kyle Hughes on 6/15/19.
//  Copyright © 2019 Kyle Hughes. All rights reserved.
//

import Foundation

enum RomanNumeralArithmeticError: Error {

    case ambiguousSubtractionError
    case subtractionWhereRightValueIsGreaterThanLeftValue

}
