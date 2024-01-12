//
//  NanoIDTests.swift
//  NanoIDTests
//
//  Created by George Cox on 9/7/19.
//  Copyright © 2019 Tundaware LLC. All rights reserved.
//

import Foundation
import XCTest

@testable import NanoID

class ID_Tests: XCTestCase {

  func test_ids_are_the_expected_size() {
    XCTAssert(NanoID(count: 21).generate().count == 21)
    XCTAssert(NanoID(count: 25).generate().count == 25)
    XCTAssert(NanoID(count: 47).generate().count == 47)
  }

  func test_ids_limited_to_alphabet_simple() {
    XCTAssertEqual(NanoID(alphabet: Alphabet("a"), count: 5).generate(), "aaaaa")
  }

  func test_ids_limited_to_alphabet_complex() {
    let alphabet = Alphabet("abc!6")
    let id = NanoID(alphabet: alphabet, count: 50)

    (0...1000).enumerated().forEach { _ in
      XCTAssertTrue(id.generate().isLimitedTo(elements: alphabet.characters))
    }
  }

  func test_ids_use_the_urlSafe_alphabet_by_default() {
    XCTAssert(NanoID().generate().isLimitedTo(elements: Alphabet.urlAllowed.characters))
  }

  func test_ids_have_flat_distribution() {
    let generators: [RandomGenerator] = [.system(), .secure(), .arc4Uniform()]
    for generator in generators {
      let idCount = 100 * 1000
      let count = 5
      let alphabet = Alphabet.lowercaseLetters
      let id = NanoID(alphabet: alphabet, count: count, generator: generator)

      let chars = (0..<idCount).reduce(into: [Character: Int]()) { acc, _ in
        id.generate().forEach { acc[$0] = (acc[$0] ?? 0) + 1 }
      }

      XCTAssertEqual(chars.count, alphabet.count)

      let dist = chars.reduce(into: (min: Double(INT_MAX), max: Double(0))) { acc, kvp in
        let distribution = Double(kvp.value * alphabet.count) / Double(idCount * count)
        if distribution > acc.max {
          acc.max = distribution
        }
        if distribution < acc.min {
          acc.min = distribution
        }
      }

      if generator is SecureRandomGenerator {
        XCTAssertLessThanOrEqual(dist.max - dist.min, 0.15)
      } else {
        XCTAssertLessThanOrEqual(dist.max - dist.min, 0.05)
      }
    }
  }

  func test_ids_do_not_collide() {
    let generators: [RandomGenerator] = [.system(), .secure(), .arc4Uniform()]
    for generator in generators {
      let id = NanoID(generator: generator)
      _ = (0..<10).reduce(into: Set<String>()) { acc, _ in
        let generated = id.generate()
        XCTAssertFalse(acc.contains(generated), "\(generator) produced collisions: \(generated):\(acc)")
        acc.insert(generated)
      }
    }
  }
}

extension Sequence where Element == Character {

  func isLimitedTo(elements: [Character]) -> Bool {
    for c in self {
      if !elements.contains(c) {
        return false
      }
    }
    return true
  }
}
