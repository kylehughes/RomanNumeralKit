//
//  SubtractiveNotationRomanNumeralTests.swift
//  RomanNumeralKit_iOS
//
//  Created by Kyle Hughes on 9/30/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation
import XCTest

@testable import RomanNumeralKit_iOS

class SubtractiveNotationRomanNumeralTests: XCTestCase {
    
    //MARK: XCTestCase Implementation
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    //MARK: Initialization Tests
    
    func testInit_string_valid() {
        // Given...



        // When...

        let xxvi = try! SubtractiveNotationRomanNumeral(from: "XXVI")
        let xxiv = try! SubtractiveNotationRomanNumeral(from: "XXIV")

        let mmdclxxxxi = try! SubtractiveNotationRomanNumeral(from: "MMDCLXXXXI")
        let mmcdlxxxix = try! SubtractiveNotationRomanNumeral(from: "MMCDLXXXIX")

        // Then...

        XCTAssert(xxvi.intValue == 26)
        XCTAssert(xxiv.intValue == 24)

        XCTAssert(mmdclxxxxi.intValue == 2691)
        XCTAssert(mmcdlxxxix.intValue == 2489)
    }
    
}
