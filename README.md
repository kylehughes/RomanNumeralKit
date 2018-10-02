# RomanNumeralKit

[![CocoaPods](https://img.shields.io/cocoapods/v/RomanNumeralKit.svg)]()
[![Build Status](https://travis-ci.org/kylehughes/RomanNumeralKit.svg?branch=mainline)](https://travis-ci.org/kylehughes/RomanNumeralKit)

First-class Roman numeral support for Swift.

## Introduction

Meaningful usage of this framework requires understanding what Roman numerals are. Background information can be found [here on Wikipedia](https://en.wikipedia.org/wiki/Roman_numerals).

### Subtractive Notation

#### Subtractive Notation Example

```swift
print(CDLIV + MMMCCCIII)                // Prints "MMMDCCLVII"
print(CDLIV + MMMCCCIII == MMMDCCLVII)  // Prints "true"
print((CDLIV + MMMCCCIII).intValue)     // Prints "3757"
print(CDLIV + MMMCCCIII == 3757)        // Prints "true"
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

#### Global Constants

Constants have been provided for every Roman numeral from 1 to 3999 (i.e. all). They can be referenced directly by using their Roman numeral characters as symbols. There is no namespacing.

The constants are created as subtractive notation Roman numerals. This is the default Roman numeral experience.

##### Global Constants Definition Example

This is an example of how the constants are defined:

```swift
...
public let CMXCV = try! SubtractiveNotationRomanNumeral(intValue:995)
public let CMXCVI = try! SubtractiveNotationRomanNumeral(intValue:996)
public let CMXCVII = try! SubtractiveNotationRomanNumeral(intValue:997)
public let CMXCVIII = try! SubtractiveNotationRomanNumeral(intValue:998)
public let CMXCIX = try! SubtractiveNotationRomanNumeral(intValue:999)
public let M = try! SubtractiveNotationRomanNumeral(intValue:1000)
public let MI = try! SubtractiveNotationRomanNumeral(intValue:1001)
public let MII = try! SubtractiveNotationRomanNumeral(intValue:1002)
public let MIII = try! SubtractiveNotationRomanNumeral(intValue:1003)
...
```

#### Manual Initialization

The only practical reason to manually instantiate a `RomanNumeral` is to do conversion from a type (e.g. `String`) (consider using a `*RomanNumeralConvertible` property instead). Otherwise, there are a fixed set of values and they are all provided as constants. Do as you please.

There are two primary initializers that must be supplied by all `RomanNumeral`s:
- `init(intValue: Int)`
- `init(symbols: [RomanNumeralSymbol])`

A variety of other initializers are provided for convenience.

The protocols `BasicNotationRomanNumeralConvertible` and `SubtractiveNotationRomanNumeralConvertible` are available for types that can transform themselves into `RomanNumeral`s. Extensions for `Foundation` classes (e.g. `Array`, `Int`, `String`) are provided.

##### Manual Initialization Example

```swift
let XIX = SubtractiveNotationRomanNumeral(intValue: 19)
let XIX = SubtractiveNotationRomanNumeral(symbols: [.X, .I, .X])
let XIX = SubtractiveNotationRomanNumeral(.X, .I, .X)
let XIX = SubtractiveNotationRomanNumeral(from: "XIX")
```

## License

`RomanNumeralKit` is available under the MIT License.

## Authors

Kyle Hughes

[![my twitter][1.1]][1]

[1.1]: https://img.shields.io/badge/Twitter-@KyleHughes-blue.svg?style=flat-square
[1]: https://www.twitter.com/KyleHughes