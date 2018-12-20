//
//  RomanNumeralError.swift
//  RomanNumeralKit
//
//  Created by Kyle Hughes on 4/16/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation

public enum RomanNumeralError: Error {

    case valueGreaterThanMaximum
    case valueLessThanMinimum

}

// MARK: - CustomStringConvertible Extension

extension RomanNumeralError: CustomStringConvertible {

    //MARK: Public Properties

    public var description: String {
        switch self {
        case .valueGreaterThanMaximum:
            return "A Roman numeral's value cannot be greater than its notation's maximum value."
        case .valueLessThanMinimum:
            return "A Roman numeral's value cannot be less than its notation's minimum value."
        }
    }

}

// MARK: - LocalizedError Extension

extension RomanNumeralError: LocalizedError {

    //MARK: Public Properties

    public var errorDescription: String? {
        return description
    }

}
