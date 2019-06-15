//
//  Sequence+Sorting.swift
//  RomanNumeralKit
//
//  Created by Kyle Hughes on 6/15/19.
//  Copyright © 2019 Kyle Hughes. All rights reserved.
//

import Foundation

// MARK: - Extension for Sequence

extension Sequence {

    internal func isSorted(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Bool {
        var iterator = makeIterator()

        guard var previous = iterator.next() else {
            // Sequence is empty
            return true
        }

        while let current = iterator.next() {
            guard try areInIncreasingOrder(previous, current) else {
                return false
            }

            previous = current
        }

        return true
    }

}
