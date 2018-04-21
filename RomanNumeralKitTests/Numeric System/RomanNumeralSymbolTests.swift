//
//  RomanNumeralSymbolTests.swift
//  RomanNumeralKitTests
//
//  Created by Kyle Hughes on 4/16/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation
import XCTest

@testable import RomanNumeralKit

//MARK: - Implementation Tests

class RomanNumeralSymbolTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
        
        XCTAssertFalse(RomanNumeralSymbol.I < RomanNumeralSymbol.I)
        XCTAssertFalse(RomanNumeralSymbol.V < RomanNumeralSymbol.V)
        XCTAssertFalse(RomanNumeralSymbol.X < RomanNumeralSymbol.X)
        XCTAssertFalse(RomanNumeralSymbol.L < RomanNumeralSymbol.L)
        XCTAssertFalse(RomanNumeralSymbol.C < RomanNumeralSymbol.C)
        XCTAssertFalse(RomanNumeralSymbol.D < RomanNumeralSymbol.D)
        XCTAssertFalse(RomanNumeralSymbol.M < RomanNumeralSymbol.M)
    }
    
}
