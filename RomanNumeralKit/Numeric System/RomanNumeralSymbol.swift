//
//  RomanNumeralSymbol.swift
//  RomanNumeralKit
//
//  Created by Kyle Hughes on 4/16/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation

public enum RomanNumeralSymbol: Int {
    
    case I = 1
    case V = 5
    case X = 10
    case L = 50
    case C = 100
    case D = 500
    case M = 1000
    
    //MARK: Public Static Properties
    
    public static let allSymbols: [RomanNumeralSymbol] = [.I, .V, .X, .L, .C, .D, .M]
    public static let allSymbolsDescending: [RomanNumeralSymbol] = allSymbols.reversed()
    
    //MARK: Public Properties
    
    var characterValue: Character {
        switch self {
        case .I:
            return "I"
        case .V:
            return "V"
        case .X:
            return "X"
        case .L:
            return "L"
        case .C:
            return "C"
        case .D:
            return "D"
        case .M:
            return "M"
        }
    }
    
    //MARK: Initialization
    
    public init(from characterValue: Character) throws {
        let potentialSymbols = RomanNumeralSymbol.allSymbols.filter { $0.characterValue == characterValue }
        guard potentialSymbols.count == 1, let symbol = potentialSymbols.first else {
            throw RomanNumeralSymbolValidationError.invalidSymbol
        }
        
        self = symbol
    }
    
    //MARK: Public Interface
    
    public func isSubtractiveFor(_ otherSymbol: RomanNumeralSymbol) -> Bool {
//        switch self {
//        case .I:
//            return otherSymbol == .V || otherSymbol == .X
//        case .V:
//            return otherSymbol == .X || otherSymbol == .L
//        case .X:
//            return otherSymbol == .L || otherSymbol == .C
//        case .L:
//            return otherSymbol == .C || otherSymbol == .D
//        case .C:
//            return otherSymbol == .D || otherSymbol == .M
//        case .D:
//            return otherSymbol == .M
//        case .M:
//            return false
//        }
        return false
    }
    
}

//MARK: - Comparable Extension

extension RomanNumeralSymbol: Comparable {
    
    public static func <(lhs: RomanNumeralSymbol, rhs: RomanNumeralSymbol) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
}
