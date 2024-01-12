//
//  RandomGenerator.swift
//
//  Created by Sereivoan Yong on 1/12/24.
//

import Foundation

extension RandomGenerator {

  public static func secure() -> Self where Self == SecureRandomGenerator {
    return SecureRandomGenerator()
  }

  public static func system() -> Self where Self == SystemRandomGenerator {
    return SystemRandomGenerator()
  }

  public static func arc4Uniform() -> Self where Self == ARC4RandomUniformGenerator {
    return ARC4RandomUniformGenerator()
  }
}

public protocol RandomGenerator {

  func characters(count: Int, in alphabet: Alphabet) -> [Character]
}

public struct SecureRandomGenerator: RandomGenerator {

  public func characters(count: Int, in alphabet: Alphabet) -> [Character] {
    var bytes = [UInt8](repeating: 0, count: count)
    let status = SecRandomCopyBytes(kSecRandomDefault, count, &bytes)
    var characters: [Character] = []
    if status == errSecSuccess {
      for byte in bytes {
        characters.append(alphabet[Int(byte) % alphabet.count])
      }
    }
    return characters
  }
}

public struct SystemRandomGenerator: RandomGenerator {

  public func characters(count: Int, in alphabet: Alphabet) -> [Character] {
    var characters: [Character] = []
    var indexGenerator = SystemRandomNumberGenerator()
    let upperBound = UInt(alphabet.count)
    for _ in 0..<count {
      let index = Int(indexGenerator.next(upperBound: upperBound))
      characters.append(alphabet[index])
    }
    return characters
  }
}

public struct ARC4RandomUniformGenerator: RandomGenerator {

  public func characters(count: Int, in alphabet: Alphabet) -> [Character] {
    var characters: [Character] = []
    let upperBound = UInt32(alphabet.count)
    for _ in 0..<count {
      let index = Int(arc4random_uniform(upperBound))
      characters.append(alphabet[index])
    }
    return characters
  }
}
