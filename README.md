# RomanNumeralKit

The numeric system of the gods.

## Introduction

Meaningful usage of this framework requires understanding what Roman numerals are. Background information can be found [here on Wikipedia](https://en.wikipedia.org/wiki/Roman_numerals).

### Basic vs. Subtractive Notation

## Installation

## Usage

Import `RomanNumeralKit` at the top of the Swift file you want to use it in.

```swift
import RomanNumeralKit
```

### Constants

### Initialization

There are two primary initializers that must be supplied by all `RomanNumeral`s:
- `init(intValue: Int)`
- `init(symbols: [RomanNumeralSymbol])`

From there, a variety of other initializers are included. The common ways to initialize `RomanNumeral`s are:

```swift
let XI = SubtractiveNotationRomanNumeral(intValue: 11)
let XI = SubtractiveNotationRomanNumeral(symbols: [.X, .I])
let XI = SubtractiveNotationRomanNumeral(.X, .I)
let XI = SubtractiveNotationRomanNumeral(from: "XI")
```

### Fixed Numerical Range