import Files
import RomanNumeralKit

final class RomanNumeralKitCodeGenerator {
    private let executablePath: String
    private let projectPath: String

    // MARK: Internal Initialization

    init(arguments: [String]) {
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

    func generateRomanNumeralConstants() {
        for numeral in RomanNumeral.minimum ... RomanNumeral.maximum {
            var unsafeSymbolsParameter: String = ""

            for (index, symbol) in numeral.subtractiveRomanNumeralSymbols.enumerated() {
                unsafeSymbolsParameter += "." + symbol.stringValue
                guard index + 1 != numeral.subtractiveRomanNumeralSymbols.count else { continue }
                unsafeSymbolsParameter += ", "
            }

            print(
                """
                /// The Roman numeral representing the Arabic numeral "\(numeral.intValue)".
                let \(numeral.stringValue) = RomanNumeral(unsafeSymbols: [\(unsafeSymbolsParameter)])

                """
            )
        }
    }

    func generateTestsForRomanNumeralConstants() {}
}
