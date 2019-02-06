//
//  DateComponents+RomanNumeral.swift
//  RomanNumeralKit
//
//  Created by Kyle Hughes on 10/1/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation

extension DateComponents {

    // MARK: Public Properties

    public var yearAsRomanNumeral: RomanNumeral? {
        guard let year = year else {
            return nil
        }

        return try? RomanNumeral(intValue: year)
    }

}
