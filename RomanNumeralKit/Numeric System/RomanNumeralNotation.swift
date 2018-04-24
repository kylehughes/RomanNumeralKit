//
//  RomanNumeralNotation.swift
//  RomanNumeralKit
//
//  Created by Kyle Hughes on 4/16/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation

//MARK: - Implementation

public enum RomanNumeralNotation {
    
    case basic
    case subtractive
    
}

//MARK: - CustomStringConvertible Extension

extension RomanNumeralNotation: CustomStringConvertible {
    
    public var description: String {
        let description: String
        switch self {
        case .basic:
            description = "Basic"
        case .subtractive:
            description = "Subtractive"
        }
        
        return description
    }
    
}
