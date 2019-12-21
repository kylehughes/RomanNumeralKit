//
//  RomanNumeralKitCodeGenerator.swift
//  RomanNumeralKitCodeGen
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

import Files
import RomanNumeralKit

internal final class RomanNumeralKitCodeGenerator {
    private let executablePath: String
    private let projectPath: String

    // MARK: Internal Initialization

    internal init(arguments: [String]) {
        guard !arguments.isEmpty else {
            fatalError("The executable path is required")
        }

        executablePath = arguments[0]

        guard arguments.count > 1 else {
            fatalError("The project path is required")
        }

        projectPath = arguments[1]
    }

    // MARK: Internal Instance Interface

    internal func generateRomanNumeralConstants() -> String {
        stride(from: RomanNumeral.minimum, to: RomanNumeral.maximum, by: 1)
            .map { $0.sourceCodeForConstantDeclaration }
            .reduce("", +)
    }
}
