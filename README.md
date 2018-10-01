# RomanNumeralKit

The numeric system of the gods.

## Overview

### Numerical Range

### Basic vs. Subtractive Notation

## Installation

## Usage

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