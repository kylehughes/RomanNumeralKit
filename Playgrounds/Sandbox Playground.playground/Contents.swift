/*:
 
 # Sandbox Playground
 
 A scratchpad for development. A convenient way to not follow TDD.
 
 */

import RomanNumeralKit

/*:
 
 ## Basic Notation Examples
 
 */

do {
    let xxviStringRomanNumeral = try RomanNumeral(from: "XXVI", notation: .basic)
    let xxviEnumRomanNumeral = try RomanNumeral(symbols: [.X, .X, .V, .I], notation: .basic)
    let xxviDecimal = 26
    
    let hello = xxviStringRomanNumeral.intValue

    xxviStringRomanNumeral == xxviEnumRomanNumeral
    xxviStringRomanNumeral.intValue == xxviDecimal
    
    let mmcdlxxivStringRomanNumeral = try RomanNumeral(from: "MMCDLXXIV", notation: .basic)
    let mmcdlxxivDecimal = 2626
    
    mmcdlxxivStringRomanNumeral.intValue == mmcdlxxivDecimal
}

/*:
 
 ## Subtractive Notation Examples
 
*/

do {
    let mmcdlxxivStringRomanNumeral = try RomanNumeral(from: "MMCDLXXIV", notation: .subtractive)
    let mmcdlxxivDecimal = 2474
    
    mmcdlxxivStringRomanNumeral.intValue == mmcdlxxivDecimal
}
