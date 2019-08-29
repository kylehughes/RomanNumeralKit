# RomanNumeralKit

[![CocoaPods Version](https://img.shields.io/cocoapods/v/RomanNumeralKit.svg?label=version)]()
[![Languages](https://img.shields.io/badge/languages-Swift-orange.svg)]()
[![CocoaPods Platforms](https://img.shields.io/cocoapods/v/RomanNumeralKit.svg)]()

[![Build Status](https://travis-ci.org/kylehughes/RomanNumeralKit.svg?branch=mainline)](https://travis-ci.org/kylehughes/RomanNumeralKit)
[![codecov](https://codecov.io/gh/kylehughes/RomanNumeralKit/branch/mainline/graph/badge.svg)](https://codecov.io/gh/kylehughes/RomanNumeralKit)

[![Twitter](https://img.shields.io/badge/twitter-@RomanNumeralKit-blue.svg)](https://twitter.com/RomanNumeralKit)

First-class Roman numeral support for Swift.

*When in Rome, code as the Romans code.*

## Introduction

Meaningful usage of this framework requires understanding what Roman numerals are. Background information can be found [on Wikipedia](https://en.wikipedia.org/wiki/Roman_numerals).

### Features

- [x] Constants provided for all 3999 standard Roman numerals.
- [x] Support for subtractive and additive notations.
- [x] Arithmetic using Roman-numeral-oriented algorithms - no integer calculations!
- [x] Conversions to-and-from popular types (e.g. `String`, `Int`).
- [x] Extensions for real-world usage (e.g. copyright text).
- [x] Conformance to all applicable numeric protocols.

### Limitations

#### Fixed Numerical Range

Standard Roman numerals as we understand them were limited to values from 1 to 3999. There is no concept of 0. Modern scholars have proposed extensions of the numeric system to support values greater than 3999 but we do not recognize any of these extensions and decry the proposers to be heretics.

Most programs do not deal with numbers higher than 3999, and the world won't exist past the year 3999 in the Gregorian calendar, so there is no need to worry.

#### iPhone Model Names

RomanNumeralKit does not support conversions to-and-from recent iPhone model names such as "Xs".

## Requirements

- iOS 10.0+ / macOS 10.12+ / tvOS 10.0+ / watchOS 3.0+
- Xcode 10.2+
- Swift 5+

## Installation

### CocoaPods

Add RomanNumeralKit to your `Podfile`:

```ruby
pod 'RomanNumeralKit', '~> 1.0`
```

Please visit the [CocoaPods website](https://cocoapods.org/) for general CocoaPods usage and installation instructions.

### Swift Package Manager

Add RomanNumeralKit to the `dependencies` value of your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/kylehughes/RomanNumeralKit.git", from: "1.0")
]
```

## Usage

Import `RomanNumeralKit` at the top of the Swift file you want to use it in.

```swift
import RomanNumeralKit
```

### Constants

Constants are provided for all valid Roman numerals, from 1 to 3,999. You should never need to use an initializer
unless you are doing conversions from other types.

All constants can be accessed directly by their using their uppercase Unicode characters.

```swift
print(MMCDIX)           // Prints "MMCDIX"
print(MMCDIX.symbols)   // Prints "[M, M, C, D, I, X]"

XCTAssertEqual(MMCDIX, RomanNumeral(.M, .M, .C, .D, .I, .X))    // True
```

### Conversions

We provide convenient mechanisms to convert `RomanNumeral`s to-and-from popular types.

It should be noted that these are true conversions: the backing values of `RomanNumeral` instances are groups of tally
marks. We do not hold `Int`references because it would not be in the spirit of the framework.

#### Constructors

Constructors are provided to convert `Int`s and `String`s to `RomanNumeral`s.

```swift
print(RomanNumeral(from: 2409))     // Prints "MMCDIX"
print(RomanNumeral(from: "MMCDIX")) // Prints "MMCDIX"
```

We also support conversions from `Int` and `String` literals when the `RomanNumeral` type can be inferred.

```swift
let numeralFromInt: RomanNumeral = 2409
let numeralFromString: RomanNumeral = "MMCDIX"

print(numeralFromInt)       // Prints "MMCDIX"
print(numeralFromString)    // Prints "MMCDIX"
```

#### Properties

Instance-level properties are provided to convert `RomanNumeral`s into `Int` and `String` values.

```swift
print(MMCDIX.intValue)      // Prints "2409"
print(MMCDIX.stringValue)   // Prints "MMCDIX"
```

We also provide various `*Convertible` protocols to allow types to return different `RomanNumeral` and
`RomanNumeralSymbol` representations of themselves.

### Arithmetic

Addition, subtraction, and multiplication operations are supported (and required) thanks to our conformance to the
`Numeric` protocol. We use algorithms that allow us to directly manipulate the Roman numeral symbols as opposed to
doing conversions to-and-from `Int`s.

#### Performance

Our committment to authenticity does have implications.

The following table compares the performance `Int` arithmetic operations to Roman numeral arithmetic operations on a 
new MacBook Pro.

| Operation (100x) | `Int`       | `RomanNumeral` | % Slower       |
| ---------------- | ----------: | -------------: | -------------: |
| Addition         | 0.00000127s |         0.151s | 11,889,663.78% |
| Subtraction      | 0.00000151s |        0.0761s |  5,992,025.98% |
| Multiplication   | 0.00000204s |        0.0575s |  4,527,459.06% |

It should be noted that this is much faster than any person from Ancient Rome could do arithmetic. Who can take issue
with progress?

### Copyright Text

The most useful feature we provide is automatic formatting of Copyright text.

```swift
print(MDCCLXXVI.copyrightText)  // Prints "Copyright © MDCCLXXVI"
```

### Additive Notation

The default notation for this framework is subtractive notation - that is what instances of `RomanNumeral`s represent.
We provide the `AdditiveRomanNumeral` struct for initialization of numerals using additive notation. We also support
conversions between the notations.

Both notations implement the `RomanNumeralProtocol` protocol and support the same general interface.

```swift
let additiveNumeral = AdditiveNotation(.M, .M, .C, .C, .C, .C, .V, .I, .I, .I, .I)

print(additiveNumeral)              // Prints "MMCCCCVIIII"
print(additiveNumeral.intValue)     // Prints "2409"

XCTAssertEqual(additiveRomanNumeral.romanNumeral, MMCDIX)           // True
XCTAssertEqual(MMCDIX.additiveRomanNumeral, additiveRomanNumeral)   // True
```

### Extensions

We provide a variety of extensions on existing Swift types to make common operations easier.

#### `Calendar` & `DateComponent` Extensions

`Calendar` objects, and the `DateComponents` they produce, are able to convert years into `RomanNumeral`s.

```swift
if let currentYear = Calendar.current.currentYearAsRomanNumeral {
    print(currentYear)                  // Prints "MMXIX"
    print(currentYear.intValue)         // Prints "2019"
    print(currentYear.copyrightText)    // Prints "Copyright © MMXIX"
}

if let americasBirthYear = Calendar.current.yearAsRomanNumeral(fromDate: americasBirthDate) {
    print(americasBirthYear)            // Prints "MDCCLXXVI"
    print(americasBirthYear.intValue)   // Prints "1776"
    print(americasBirthYear.copyrightText)    // Prints "Copyright © MDCCLXXVI"
}
```

#### `Int` & `String` Extensions

We conform `Int` and `String` to the `*RomanNumeralConvertible` protocols to complete the ouroboros with these
foundational types.

```swift
print(2409.romanNumeral)                    // Prints "MMCDIX"
print(2409.additiveRomanNumeral)            // Prints "MMCCCCVIIII"
print("MMCDIX".romanNumeral)                // Prints "MMCDIX"
print("MMCCCCVIIII".additiveRomanNumeral)   // Prints "MMCCCCVIIII"
```

## Development

### Pre-Commit Hooks

We use [Komondor](https://github.com/shibapm/Komondor) to install pre-commit hooks to run formatting and linting.
The following command should be run once after cloning the repository.

```sh
swift run komondor install
```

## License

`RomanNumeralKit` is available under the MIT License.

## Authors

Kyle Hughes

[![my twitter][social_twitter_image]][social_twitter_url]

[social_twitter_image]: https://img.shields.io/badge/Twitter-@KyleHughes-blue.svg
[social_twitter_url]: https://www.twitter.com/KyleHughes
