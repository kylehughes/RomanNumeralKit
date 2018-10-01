//
//  RomanNumeralTests.swift
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

//MARK: - Implementation

class RomanNumeralTests: XCTestCase {
    
    //MARK: Int Initialization Tests
    
    func testInitInt_basicNotation_valid() {
        // Given...
        
        let notation = RomanNumeralNotation.basic
        
        let expectationMcmxcixSymbols: [RomanNumeralSymbol] = [.M, .M, .C, .C, .X, .X, .I] // 1999 for subtractive lol
        
        // When...
        
        // Long addition w/ few OOO symbols
        let mcmxcix = RomanNumeral(intValue: 2221, notation: notation)
        
        // Then...
        
        XCTAssert(mcmxcix.symbols == expectationMcmxcixSymbols)
    }
    
    //MARK: String Initialization Tests
    
    func testInitString_basicNotation_valid() {
        // Given...
        
        let notation = RomanNumeralNotation.basic
        
        // When...
        
        // Basic addition
        let xxvi = try! RomanNumeral(from: "XXVI", notation: notation)
        // Basic addition w/ single OOO symbol
        let xxiv = try! RomanNumeral(from: "XXIV", notation: notation)
        
        // Long addition
        let mmdclxxxxi = try! RomanNumeral(from: "MMDCLXXXXI", notation: notation)
        // Long addition w/ single OOO symbol
        let mmcdlxxxix = try! RomanNumeral(from: "MMCDLXXXIX", notation: notation)
        
        // Then...
        
        XCTAssert(xxvi.intValue == 26)
        XCTAssert(xxiv.intValue == 26)
        
        XCTAssert(mmdclxxxxi.intValue == 2691)
        XCTAssert(mmcdlxxxix.intValue == 2691)
    }
    
    func testInitString_basicNotation_throwInvalidCharacters() {
        // Given...
        
        let notation = RomanNumeralNotation.basic
        
        // When...
        
        do {
           let _ = try RomanNumeral(from: "MMCDLXXRIX", notation: notation)
        } catch {
            //Then ...
            
            XCTAssert(true)
        }
    }
    
    func testInitString_subtractiveNotation_valid() {
        // Given...
        
        let notation = RomanNumeralNotation.subtractive
        
        // When...
        
        let xxvi = try! RomanNumeral(from: "XXVI", notation: notation)
        let xxiv = try! RomanNumeral(from: "XXIV", notation: notation)
        
        let mmdclxxxxi = try! RomanNumeral(from: "MMDCLXXXXI", notation: notation)
        let mmcdlxxxix = try! RomanNumeral(from: "MMCDLXXXIX", notation: notation)
        
        // Then...
        
        XCTAssert(xxvi.intValue == 26)
        XCTAssert(xxiv.intValue == 24)
        
        XCTAssert(mmdclxxxxi.intValue == 2691)
        XCTAssert(mmcdlxxxix.intValue == 2489)
    }
    
}
