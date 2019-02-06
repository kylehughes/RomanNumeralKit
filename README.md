# [WIP] RomanNumeralKit [WIP]

[![CocoaPods](https://img.shields.io/cocoapods/v/RomanNumeralKit.svg)]()
[![Build Status](https://travis-ci.org/kylehughes/RomanNumeralKit.svg?branch=mainline)](https://travis-ci.org/kylehughes/RomanNumeralKit)
[![codecov](https://codecov.io/gh/kylehughes/RomanNumeralKit/branch/mainline/graph/badge.svg)](https://codecov.io/gh/kylehughes/RomanNumeralKit)

First-class Roman numeral support for Swift.

## Introduction

Meaningful usage of this framework requires understanding what Roman numerals are. Background information can be found [here on Wikipedia](https://en.wikipedia.org/wiki/Roman_numerals).

### Subtractive Notation

#### Examples

```swift
print(CDLIV + MMMCCCIII)                // Prints "MMMDCCLVII"
print(CDLIV + MMMCCCIII == MMMDCCLVII)  // Prints "true"
print(MMMDCCLVII.intValue)              // Prints "3757"
print(MMMDCCLVII == 3757)               // Prints "true"
```

### Basic Notation

#### Basic Notation Example

## Limitations

### Fixed Numerical Range

Most* programs don't deal with numbers higher than 3999.

### iPhone & macOS Names

## Installation

## Usage

Import `RomanNumeralKit` at the top of the Swift file you want to use it in.

```swift
import RomanNumeralKit
```

### Initialization

#### Manual Initialization

The only practical reason to manually instantiate a `RomanNumeralProtocol` is to do conversion from a type (e.g. `String`) (consider using a `*RomanNumeralConvertible` property instead). Otherwise, there are a fixed set of values and they are all provided as constants. Do as you please.

There are two primary initializers that must be supplied by all `RomanNumeralProtocol`s:

- `init(intValue: Int)`
- `init(symbols: [RomanNumeralSymbol])`

A variety of other initializers are provided for convenience.

The protocols `RomanNumeralConvertible` and `BasicNotationRomanNumeralConvertible` are available for types that can transform themselves into `RomanNumeralProtocol`s. Extensions for `Foundation` classes (e.g. `Array`, `Int`, `String`) are provided.

##### Examples

```swift
let XIX = SubtractiveNotationRomanNumeral(intValue: 19)
let XIX = SubtractiveNotationRomanNumeral(symbols: [.X, .I, .X])
let XIX = SubtractiveNotationRomanNumeral(.X, .I, .X)
let XIX = SubtractiveNotationRomanNumeral(from: "XIX")
```

### Extensions

#### Foundation Extensions

##### `Calendar` Extensions

###### Examples

```swift
if let currentYear = Calendar.current.currentYearAsRomanNumeral {
    print(currentYear)          // Prints "MMXVIII"
    print(currentYear.intValue) // Prints "2018"
}

if let americasBirthYear = Calendar.current.yearAsRomanNumeral(fromDate: americasBirthDate) {
    print(americasBirthYear)            // Prints "MDCCLXXVI"
    print(americasBirthYear.intValue)   // Prints "1776"
}
```

### Copyright Text

#### Examples

```swift
print(MDCCLXXVI.copyrightText)  // Prints "Copyright © MDCCLXXVI"

if let currentYear = Calendar.current.currentYearAsRomanNumeral {
    print(currentYear.copyrightText)  // Prints "Copyright © MMXVIII"
}
```

## License

`RomanNumeralKit` is available under the MIT License.

## Authors

Kyle Hughes

[![my twitter][social_twitter_image]][social_twitter_url]

[social_twitter_image]: https://img.shields.io/badge/Twitter-@KyleHughes-blue.svg?style=flat-square
[social_twitter_url]: https://www.twitter.com/KyleHughes
