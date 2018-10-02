//
//  Calendar+RomanNumeral.swift
//  RomanNumeralKit
//
//  Created by Kyle Hughes on 10/1/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation

extension Calendar {
    
    //MARK: Public Properties
    
    public var currentYearAsRomanNumeral: RomanNumeral? {
        return yearAsRomanNumeral(fromDate: Date())
    }
    
    //MARK: Public Interface
    
    public func yearAsRomanNumeral(fromDate date: Date) -> RomanNumeral? {
        let dateComponents = self.dateComponents([.year], from: date)
        
        return dateComponents.yearAsRomanNumeral
    }
    
}
