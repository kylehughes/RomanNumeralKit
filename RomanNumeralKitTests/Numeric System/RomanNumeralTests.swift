//
//  RomanNumeralTests.swift
//  RomanNumeralKitTests
//
//  Created by Kyle Hughes on 4/20/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation
import XCTest

@testable import RomanNumeralKit

//MARK: - Implementation

class RomanNumeralTests: XCTestCase {
    
    //MARK: Tests
    
    func testInitString_basicNotation() {
        // Given...
        
        let notation = RomanNumeralNotation.basic
        
        // When...
        
        let xxvi = try! RomanNumeral(from: "XXVI", notation: notation)
        let xxiv = try! RomanNumeral(from: "XXIV", notation: notation)
        
        let mmdclxxxxi = try! RomanNumeral(from: "MMDCLXXXXI", notation: .basic)
        let mmcdlxxxix = try! RomanNumeral(from: "MMCDLXXXIX", notation: .basic)
        
        // Then...
        
        XCTAssert(xxvi.intValue == 26)
        XCTAssert(xxiv.intValue == 26)
        
        XCTAssert(mmcdlxxxix.intValue == 2691)
        XCTAssert(mmcdlxxxix.intValue == 2691)
    }
    
}
