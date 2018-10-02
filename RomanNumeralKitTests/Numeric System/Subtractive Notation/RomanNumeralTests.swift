//
//  RomanNumeralTests.swift
//  RomanNumeralKit
//
//  Created by Kyle Hughes on 9/30/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation
import XCTest

@testable import RomanNumeralKit

class RomanNumeralTests: XCTestCase {
    
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
        
        
        // When...
        
        // Basic addition
        let XXVI = try! RomanNumeral(intValue: 26)
        // Basic addition w/ single OOO symbol
        let XXIV = try! RomanNumeral(intValue: 24)
        
        // Long addition
        let MMDCXCI = try! RomanNumeral(intValue: 2691)
        // Long addition w/ two OOO symbols
        let MMCDLXXXIX = try! RomanNumeral(intValue: 2489)
        
        // Then...
        
        XCTAssert(XXVI.symbols == [.X, .X, .V, .I])
        XCTAssert(XXIV.symbols == [.X, .X, .I, .V])
        
        XCTAssert(MMDCXCI.symbols == [.M, .M, .D, .C, .X, .C, .I])
        XCTAssert(MMCDLXXXIX.symbols == [.M, .M, .C, .D, .L, .X, .X, .X, .I, .X])
    }
    
    func testInit_symbols() {
        // Given...
        
        
        // When...
        
        // Basic addition
        let XXVI = try! RomanNumeral(symbols: [.X, .X, .V, .I])
        // Basic addition w/ single OOO symbol
        let XXIV = try! RomanNumeral(symbols: [.X, .X, .I, .V])
        
        // Long addition
        let MMDCXCI = try! RomanNumeral(symbols: [.M, .M, .D, .C, .X, .C, .I])
        // Long addition w/ single OOO symbol
        let MMCDLXXXIX = try! RomanNumeral(symbols: [.M, .M, .C, .D, .L, .X, .X, .X, .I, .X])
        
        // Then...
        
        XCTAssert(XXVI.intValue == 26)
        XCTAssert(XXIV.intValue == 24)
        
        XCTAssert(MMDCXCI.intValue == 2691)
        XCTAssert(MMCDLXXXIX.intValue == 2489)
    }
    
    //MARK: Performance Tests
    
    func test_perf_initializeEntireNumericalSpace_fromInt() {
        measure {
            for i in RomanNumeral.minimumIntValue...RomanNumeral.maximumIntValue {
                let _ = try! RomanNumeral(intValue: i)
            }
        }
    }
    
    func test_perf_initializeEntireNumericalSpace_fromSymbols() {
        let allSymbolCollections = (RomanNumeral.minimumIntValue...RomanNumeral.maximumIntValue).map { try! RomanNumeral(intValue: $0).symbols }
        
        measure {
            allSymbolCollections.forEach { let _ = try! RomanNumeral(symbols: $0) }
        }
    }
    
}
