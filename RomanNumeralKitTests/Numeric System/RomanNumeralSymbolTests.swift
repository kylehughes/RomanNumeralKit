//
//  RomanNumeralSymbolTests.swift
//  RomanNumeralKitTests
//
//  Created by Kyle Hughes on 4/16/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation
import XCTest

@testable import RomanNumeralKit_iOS

class RomanNumeralSymbolTests: XCTestCase {
    
    //MARK: XCTestCase Implementation
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
}

//MARK: - Comparable Extension Tests

extension RomanNumeralSymbolTests {
    
    func testLessThan() {
        XCTAssert(RomanNumeralSymbol.I < RomanNumeralSymbol.V)
        XCTAssert(RomanNumeralSymbol.V < RomanNumeralSymbol.X)
        XCTAssert(RomanNumeralSymbol.X < RomanNumeralSymbol.L)
        XCTAssert(RomanNumeralSymbol.L < RomanNumeralSymbol.C)
        XCTAssert(RomanNumeralSymbol.C < RomanNumeralSymbol.D)
        XCTAssert(RomanNumeralSymbol.D < RomanNumeralSymbol.M)
        
        XCTAssertFalse(RomanNumeralSymbol.V < RomanNumeralSymbol.I)
        XCTAssertFalse(RomanNumeralSymbol.X < RomanNumeralSymbol.V)
        XCTAssertFalse(RomanNumeralSymbol.L < RomanNumeralSymbol.X)
        XCTAssertFalse(RomanNumeralSymbol.C < RomanNumeralSymbol.L)
        XCTAssertFalse(RomanNumeralSymbol.D < RomanNumeralSymbol.C)
        XCTAssertFalse(RomanNumeralSymbol.M < RomanNumeralSymbol.D)
        
        XCTAssertFalse(RomanNumeralSymbol.I < RomanNumeralSymbol.I)
        XCTAssertFalse(RomanNumeralSymbol.V < RomanNumeralSymbol.V)
        XCTAssertFalse(RomanNumeralSymbol.X < RomanNumeralSymbol.X)
        XCTAssertFalse(RomanNumeralSymbol.L < RomanNumeralSymbol.L)
        XCTAssertFalse(RomanNumeralSymbol.C < RomanNumeralSymbol.C)
        XCTAssertFalse(RomanNumeralSymbol.D < RomanNumeralSymbol.D)
        XCTAssertFalse(RomanNumeralSymbol.M < RomanNumeralSymbol.M)
    }
    
}
