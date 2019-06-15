//
//  RomanNumeralTallyMark.swift
//  RomanNumeralKit
//
//  Created by Kyle Hughes on 6/12/19.
//  Copyright © 2019 Kyle Hughes. All rights reserved.
//

public struct RomanNumeralTallyMark: Equatable {

    // MARK: Public Initialization

    public init() {}

}

// MARK: - CustomStringConvertible Extension

extension RomanNumeralTallyMark: CustomStringConvertible {

    public var description: String {
        return "I"
    }

}

// MARK: - CustomDebugStringConvertible Extension

extension RomanNumeralTallyMark: CustomDebugStringConvertible {

    public var debugDescription: String {
        return description
    }

}
