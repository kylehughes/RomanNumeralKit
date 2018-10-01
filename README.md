# RomanNumeralKit

The numeric system of the gods.

## Introduction

Meaningful usage of this framework requires understanding what Roman numerals are. Background information can be found [here on Wikipedia](https://en.wikipedia.org/wiki/Roman_numerals).

### Subtractive Notation

#### Subtractive Notation Example

### Basic Notation

#### Basic Notation Example

## Installation

## Usage

Import `RomanNumeralKit` at the top of the Swift file you want to use it in.

```swift
import RomanNumeralKit
```

### Initialization

#### Global Constants

The constants are only provided for *subtractive notation*. This is the default experience that the majority of consumers want.

#### Manual Initialization

There are two primary initializers that must be supplied by all `RomanNumeral`s:
- `init(intValue: Int)`
- `init(symbols: [RomanNumeralSymbol])`

A variety of other convenient initializers are provided. The common ways to initialize `RomanNumeral`s are:

```swift
// Subtractive Notation
let XIX = SubtractiveNotationRomanNumeral(intValue: 19)
let XIX = SubtractiveNotationRomanNumeral(symbols: [.X, .I, .X])
let XIX = SubtractiveNotationRomanNumeral(.X, .I, .X)
let XIX = SubtractiveNotationRomanNumeral(from: "XIX")

// Basic Notation
let basicXIX = BasicNotationRomanNumeral(intValue: 21)
let basicXIX = BasicNotationRomanNumeral(symbols: [.X, .I, .X])
let basicXIX = BasicNotationRomanNumeral(.X, .I, .X)
let basicXIX = BasicNotationRomanNumeral(from: "XIX")
```

The protocols `BasicNotationRomanNumeralConvertible` and `SubtractiveNotationRomanNumeralConvertible` are available for types that can transform themselves into `RomanNumeral`s. Extensions for `Foundation` classes (e.g. `Array`, `Int`, `String`) are provided.

## Limitations

### Fixed Numerical Range

## License

`RomanNumeralKit` is available under the MIT License.

## Authors

Kyle Hughes

[![my twitter][1.1]][1]
[1.1]: https://img.shields.io/badge/Twitter-@KyleHughes-blue.svg?style=flat-square
[1]: https://www.twitter.com/KyleHughes