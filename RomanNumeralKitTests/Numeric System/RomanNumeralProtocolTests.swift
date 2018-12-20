//
//  RomanNumeralProtocolTests.swift
//  RomanNumeralKit
//
//  Created by Kyle Hughes on 9/30/18.
//  Copyright © 2018 Kyle Hughes. All rights reserved.
//

import Foundation
import XCTest

@testable import RomanNumeralKit

class RomanNumeralProtocolTests: XCTestCase {

    // MARK: XCTestCase Implementation

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Initialization Tests

    func testInit_string_errorInvalidCharacters() {
        // Given...

        // When...

        do {
            _ = try BasicNotationRomanNumeral(from: "MMCDLXXRIX")
        } catch {
            //Then ...

            XCTAssert(true)
        }
    }

}
