//
//  ConversionAlgorithm.swift
//  RomanNumeralKit
//
//  Copyright © 2019 Kyle Hughes.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

public protocol ConversionAlgorithm {
    // MARK: Public Associated Types

    associatedtype Failure: Error
    associatedtype From
    associatedtype To

    // MARK: Public Static Interface

    static func convert(from: From) -> Result<To, Failure>
}

// MARK: - Implementation

public extension ConversionAlgorithm {
    // MARK: Public Static Interface

    static func convert(from: From) throws -> To {
        try convert(from: from).get()
    }

    static func convert<BridgeAlgorithm>(
        from: BridgeAlgorithm.From,
        bridgedBy bridge: BridgeAlgorithm.Type
    ) -> Result<To, BridgedConversionAlgorithmError>
        where
        BridgeAlgorithm: ConversionAlgorithm,
        BridgeAlgorithm.To == From {
        switch bridge.convert(from: from) {
        case let .failure(error):
            return .failure(.bridgeFailure(error: error))
        case let .success(bridgedFromValue):
            switch convert(from: bridgedFromValue) {
            case let .failure(error):
                return .failure(.localFailure(error: error))
            case let .success(convertedValue):
                return .success(convertedValue)
            }
        }
    }
}

// MARK: - Extension Where Failure == Never

public extension ConversionAlgorithm where Failure == Never {
    // MARK: Public Static Interface

    static func convert(from: From) -> To {
        switch convert(from: from) {
        case .failure:
            fatalError("Conversion algorithm failed even though its Failure type is Never")
        case let .success(convertedValue):
            return convertedValue
        }
    }

    static func convert<BridgeAlgorithm>(
        from: BridgeAlgorithm.From,
        bridgedBy bridge: BridgeAlgorithm.Type
    ) -> To
        where
        BridgeAlgorithm: ConversionAlgorithm,
        BridgeAlgorithm.Failure == Failure,
        BridgeAlgorithm.To == From {
        convert(from: bridge.convert(from: from))
    }
}
