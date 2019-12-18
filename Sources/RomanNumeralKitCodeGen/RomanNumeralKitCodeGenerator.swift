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
