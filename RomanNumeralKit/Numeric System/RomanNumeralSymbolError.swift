//
//  RomanNumeralSymbolError.swift
//  RomanNumeralKit
//
//  Created by Kyle Hughes on 9/30/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation

public enum RomanNumeralSymbolError: Error {
    
    case unrecognizedCharacter(character: Character)
    
}
