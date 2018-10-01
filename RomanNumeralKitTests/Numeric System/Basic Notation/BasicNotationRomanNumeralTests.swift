//
//  BasicNotationRomanNumeralTests.swift
//  RomanNumeralKitTests
//
//  Created by Kyle Hughes on 4/20/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//
//  OOO = Out of Order
//  w/ = with
//

import Foundation
import XCTest

@testable import RomanNumeralKit_iOS

class BasicNotationRomanNumeralTests: XCTestCase {
    
    //MARK: XCTestCase Implementation
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //MARK: Initialization Tests
    
    func testInit_int() {
        // Given...
        
        let expectationMcmxcixSymbols: [RomanNumeralSymbol] = [.M, .M, .C, .C, .X, .X, .I] // 1999 for subtractive lol
        
        // When...
        
        // Long addition w/ few OOO symbols
        let mcmxcix = try! BasicNotationRomanNumeral(intValue: 2221)
        
        // Then...
        
        XCTAssert(mcmxcix.symbols == expectationMcmxcixSymbols)
    }
    
    func testInit_symbols() {
        // Given...

        
        // When...
        
        // Basic addition
        let xxvi = try! BasicNotationRomanNumeral(symbols: [.X, .X, .V, .I])
        // Basic addition w/ single OOO symbol
        let xxiv = try! BasicNotationRomanNumeral(symbols: [.X, .X, .I, .V])
        
        // Long addition
        let mmdclxxxxi = try! BasicNotationRomanNumeral(symbols: [.M, .M, .D, .C, .L, .X, .X, .X, .X, .I])
        // Long addition w/ single OOO symbol
        let mmcdlxxxix = try! BasicNotationRomanNumeral(symbols: [.M, .M, .D, .C, .L, .X, .X, .X, .I, .X])
        
        // Then...
        
        XCTAssert(xxvi.intValue == 26)
        XCTAssert(xxiv.intValue == 26)
        
        XCTAssert(mmdclxxxxi.intValue == 2691)
        XCTAssert(mmcdlxxxix.intValue == 2691)
    }
    
    //MARK: Performance Tests
    
    func test_perf_entireNumericalSpaceInitialization_Int() {
        measure {
            for i in BasicNotationRomanNumeral.minimumIntValue...BasicNotationRomanNumeral.maximumIntValue {
                let _ = try! SubtractiveNotationRomanNumeral(intValue: i)
            }
        }
    }
    
    func test_perf_entireNumericalSpaceInitialization_Symbols() {
        let allSymbolCollections = (BasicNotationRomanNumeral.minimumIntValue...BasicNotationRomanNumeral.maximumIntValue).map { try! BasicNotationRomanNumeral(intValue: $0).symbols }
        
        measure {
            allSymbolCollections.forEach { let _ = try! BasicNotationRomanNumeral(symbols: $0) }
        }
    }
    
}
