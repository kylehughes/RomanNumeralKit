//
//  SubtractiveRomanNumeralSymbol.swift
//  RomanNumeralKit
//
//  Created by Kyle Hughes on 9/30/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation

// swiftlint:disable identifier_name

public enum SubtractiveRomanNumeralSymbol: Int {
    
    case I  = 1
    case IV = 4
    case V  = 5
    case IX = 9
    case X  = 10
    case XL = 40
    case L  = 50
    case XC = 90
    case C  = 100
    case CD = 400
    case D  = 500
    case CM = 900
    case M  = 1000
    
    //MARK: Public Static Properties
    
    public static let allSymbols: [SubtractiveRomanNumeralSymbol] = [
        .I,
        .IV,
        .V,
        .IX,
        .X,
        .XL,
        .L,
        .XC,
        .C,
        .CD,
        .D,
        .CM,
        .M
    ]
    
    public static let allSymbolsDescending = allSymbols.reversed()
    
}

//MARK: - Comparable Extension

extension SubtractiveRomanNumeralSymbol: Comparable {
    
    public static func <(lhs: SubtractiveRomanNumeralSymbol, rhs: SubtractiveRomanNumeralSymbol) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
}

//MARK: - RomanNumeralSymbolsConvertible Extension {

extension SubtractiveRomanNumeralSymbol: RomanNumeralSymbolsConvertible {
    
    var romanNumeralSymbols: [RomanNumeralSymbol] {
        switch self {
        case .I:
            return [.I]
        case .IV:
            return [.I, .V]
        case .V:
            return [.V]
        case .IX:
            return [.I, .X]
        case .X:
            return [.X]
        case .XL:
            return [.X, .L]
        case .L:
            return [.L]
        case .XC:
            return [.X, .C]
        case .C:
            return [.C]
        case .CD:
            return [.C, .D]
        case .D:
            return [.D]
        case .CM:
            return [.C, .M]
        case .M:
            return [.M]
        }
    }
    
}
