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

    internal func generateRomanNumeralConstants() {
        for numeral in RomanNumeral.minimum ... RomanNumeral.maximum {
            print(numeral.sourceCodeForConstantDeclaration)
            print()
        }
    }

    internal func generateTestsForRomanNumeralConstants() {}
}

internal protocol ConstantSourceCodeGeneratable {
    var sourceCodeForConstant: String { get }
}

internal protocol ConstantDeclarationSourceCodeGeneratable {
    var sourceCodeForConstantDeclaration: String { get }
}

extension RomanNumeral: ConstantSourceCodeGeneratable {
    // MARK: Internal Instance Interface

    internal var sourceCodeForConstant: String {
        "RomanNumeral(unsafeSymbols: \(subtractiveRomanNumeralSymbols.sourceCodeForConstant))"
    }
}

extension RomanNumeral: ConstantDeclarationSourceCodeGeneratable {
    // MARK: Internal Instance Interface

    internal var sourceCodeForConstantDeclaration: String {
        """
        /// The Roman numeral representing the Arabic numeral "\(intValue)".
        let \(stringValue) = \(sourceCodeForConstant)
        """
    }
}

extension Array: ConstantSourceCodeGeneratable {
    // MARK: Internal Instance Interface

    internal var sourceCodeForConstant: String {
        var elements: String = ""

        for (index, element) in enumerated() {
            elements += ".\(element)"

            guard index + 1 != count else {
                continue
            }

            elements += ", "
        }

        return "[\(elements)]"
    }
}
