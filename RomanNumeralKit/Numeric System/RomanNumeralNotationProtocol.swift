//
//  RomanNumeralNotationProtocol.swift
//  RomanNumeralKit
//
//  Created by Kyle Hughes on 10/7/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation

public protocol RomanNumeralNotationProtocol {
    
    associatedtype RomanNumeralType: RomanNumeralProtocol
    
    //MARK: Static Properties
    
    static var maximum: RomanNumeralType { get }
    static var minimum: RomanNumeralType { get }
    
    //MARK: Static Interface

    static func condense(symbols: [RomanNumeralSymbol]) -> [RomanNumeralSymbol]
    
}
