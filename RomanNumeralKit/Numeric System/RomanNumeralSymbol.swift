//
//  RomanNumeralSymbol.swift
//  RomanNumeralKit
//
//  Created by Kyle Hughes on 4/16/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation

//MARK: - Implementation

public enum RomanNumeralSymbol: Int {
    
    case I = 1
    case V = 5
    case X = 10
    case L = 50
    case C = 100
    case D = 500
    case M = 1000
    
    //MARK: Public Static Properties
    
    static let allSymbolsAscending: [RomanNumeralSymbol] = [.I, .V, .X, .L, .C, .D, .M]
    static let allSymbolsDescending: [RomanNumeralSymbol] = [.M, .D, .C, .L, .X, .V, .I]
    
    //MARK: Public Computed Properties
    
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
    
    init(from characterValue: Character) throws {
        let potentialSymbols = RomanNumeralSymbol.allSymbolsAscending.filter { $0.characterValue == characterValue }
        guard potentialSymbols.count == 1, let symbol = potentialSymbols.first else {
            throw RomanNumeralSymbolValidationError.invalidSymbol
        }
        
        self = symbol
    }
    
    //MARK: Public Interface
    
    func subtractiveFor(_ otherSymbol: RomanNumeralSymbol) -> Bool {
        switch self {
        case .I:
            return otherSymbol == .V || otherSymbol == .X
        case .V:
            return otherSymbol == .X || otherSymbol == .L
        case .X:
            return otherSymbol == .L || otherSymbol == .C
        case .L:
            return otherSymbol == .C || otherSymbol == .D
        case .C:
            return otherSymbol == .D || otherSymbol == .M
        case .D:
            return otherSymbol == .M
        case .M:
            return false
        }
    }
    
}

//MARK: - Comparable Extension

extension RomanNumeralSymbol: Comparable {
    
    static public func <(lhs: RomanNumeralSymbol, rhs: RomanNumeralSymbol) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
}
